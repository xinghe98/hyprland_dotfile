#!/bin/bash

stack_file="/tmp/hide_window_stack.txt"

# exec-if 依赖此退出码：非 0 → waybar 隐藏模块
[ ! -f "$stack_file" ] || [ ! -s "$stack_file" ] && exit 1

count=$(wc -l < "$stack_file")

# 每行格式化为 "[class]  title"，作为 tooltip 多行文本
tooltip=$(awk -F'|' '{printf "[%s]  %s\n", $2, $3}' "$stack_file")

# 用 jq 输出合法 JSON，避免手动转义特殊字符
jq -cn \
    --arg text "󰈉 ${count}" \
    --arg tooltip "$tooltip" \
    --arg class "active" \
    '{text: $text, tooltip: $tooltip, class: $class}'
