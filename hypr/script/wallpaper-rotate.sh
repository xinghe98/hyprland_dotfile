#!/bin/bash
# 随机壁纸轮换脚本
# 使用 swww 实现带过渡动画的壁纸切换

WALLPAPER_DIR="$HOME/.config/hypr/images"
INTERVAL=1800  # 默认 30 分钟 (1800 秒)

# 过渡动画类型: simple, fade, left, right, top, bottom, wipe, wave, grow, center, any, outer, random
TRANSITION="random"
TRANSITION_DURATION=2  # 过渡动画时长（秒）

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--interval)
            INTERVAL="$2"
            shift 2
            ;;
        -d|--dir)
            WALLPAPER_DIR="$2"
            shift 2
            ;;
        -t|--transition)
            TRANSITION="$2"
            shift 2
            ;;
        --once)
            # 只换一次壁纸，不循环
            ONCE=true
            shift
            ;;
        -h|--help)
            echo "用法: $0 [选项]"
            echo ""
            echo "选项:"
            echo "  -i, --interval <秒>     壁纸切换间隔（默认: 1800秒 = 30分钟）"
            echo "  -d, --dir <目录>        壁纸目录（默认: ~/.config/hypr/images）"
            echo "  -t, --transition <类型> 过渡动画类型（默认: random）"
            echo "      可选: simple, fade, left, right, top, bottom, wipe, wave, grow, center, any, outer, random"
            echo "  --once                  只换一次壁纸，不循环"
            echo "  -h, --help              显示此帮助"
            exit 0
            ;;
        *)
            echo "未知选项: $1"
            exit 1
            ;;
    esac
done

# 检查 swww 是否安装
if ! command -v swww &> /dev/null; then
    echo "错误: swww 未安装。请先安装: paru -S swww 或 yay -S swww"
    exit 1
fi

# 确保 swww-daemon 正在运行
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo "启动 swww-daemon..."
    swww-daemon &
    sleep 1
fi

# 获取随机壁纸
get_random_wallpaper() {
    find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" -o -name "*.gif" \) | shuf -n 1
}

# 设置壁纸
set_wallpaper() {
    local wallpaper="$1"
    if [[ -f "$wallpaper" ]]; then
        echo "[$(date '+%H:%M:%S')] 切换壁纸: $(basename "$wallpaper")"
        swww img "$wallpaper" \
            --transition-type "$TRANSITION" \
            --transition-duration "$TRANSITION_DURATION" \
            --transition-fps 60
    fi
}

# 主循环
echo "壁纸轮换已启动"
echo "  目录: $WALLPAPER_DIR"
echo "  间隔: ${INTERVAL}秒"
echo "  过渡: $TRANSITION"
echo ""

# 立即设置一次壁纸
set_wallpaper "$(get_random_wallpaper)"

if [[ "$ONCE" == true ]]; then
    exit 0
fi

# 循环切换
while true; do
    sleep "$INTERVAL"
    set_wallpaper "$(get_random_wallpaper)"
done
