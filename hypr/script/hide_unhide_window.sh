#!/bin/bash

stack_file="/tmp/hide_window_stack.txt"

function hide_window() {
    local window_info pid class title

    window_info=$(hyprctl activewindow -j)
    pid=$(echo "$window_info" | jq '.pid')
    class=$(echo "$window_info" | jq -r '.class')
    title=$(echo "$window_info" | jq -r '.title')

    # 没有活动窗口时退出
    [ -z "$pid" ] || [ "$pid" == "null" ] && return 1

    hyprctl dispatch movetoworkspacesilent 88,pid:"$pid"
    echo "${pid}|${class}|${title}" >> "$stack_file"
}

function show_window() {
    # 没有隐藏的窗口时退出
    [ ! -f "$stack_file" ] || [ ! -s "$stack_file" ] && return 0

    local selected line_num pid current_workspace

    # 用 rofi 列出所有隐藏窗口，-format i 返回 0-based 索引
    # 格式：显示文字\0icon\x1f图标名  （\000=null byte，\037=unit separator）
    selected=$(awk -F'|' '{printf "%-20s  %s\000icon\037%s\n", $2, $3, tolower($2)}' "$stack_file" \
        | rofi -dmenu \
               -p "󰘓 恢复隐藏窗口" \
               -i \
               -format i \
               -show-icons \
               -theme-str 'window {width: 50%;}')

    # 用户取消选择
    [ -z "$selected" ] && return 0

    # rofi 返回 0-based 索引，转为 1-based 行号
    line_num=$((selected + 1))

    pid=$(sed -n "${line_num}p" "$stack_file" | cut -d'|' -f1)
    [ -z "$pid" ] && return 1

    current_workspace=$(hyprctl activeworkspace -j | jq '.id')
    hyprctl dispatch movetoworkspacesilent "$current_workspace",pid:"$pid"
    hyprctl dispatch focuswindow pid:"$pid"

    # 从堆栈文件中删除已恢复的条目
    sed -i "${line_num}d" "$stack_file"
}

# ── 入口 ──────────────────────────────────────────────────────────────────────
if [ -n "$1" ]; then
    case "$1" in
        h) hide_window ;;
        s) show_window ;;
    esac
fi
