#!/bin/bash
#
# Hyprland Dotfiles 安装脚本
# 适用于 Arch Linux 及其衍生发行版
#

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_step() { echo -e "${PURPLE}[STEP]${NC} $1"; }

# 检查是否为 Arch Linux
check_arch() {
    if ! command -v pacman &> /dev/null; then
        print_error "此脚本仅适用于 Arch Linux 及其衍生发行版"
        exit 1
    fi
}

# 检查 AUR 助手
check_aur_helper() {
    if command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    else
        print_warning "未检测到 AUR 助手 (paru/yay)"
        print_info "正在安装 paru..."
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        cd /tmp/paru && makepkg -si --noconfirm
        cd - > /dev/null
        AUR_HELPER="paru"
    fi
    print_success "使用 AUR 助手: $AUR_HELPER"
}

# 安装核心依赖
install_core() {
    print_step "安装 Hyprland 核心组件..."
    
    local core_packages=(
        # Hyprland 核心
        hyprland
        xdg-desktop-portal-hyprland
        
        # Wayland 基础
        wayland
        wayland-protocols
        xorg-xwayland
        qt5-wayland
        qt6-wayland
    )
    
    sudo pacman -S --needed --noconfirm "${core_packages[@]}"
    print_success "核心组件安装完成"
}

# 安装终端和 Shell
install_terminal() {
    print_step "安装终端和 Shell..."
    
    local packages=(
        kitty
        alacritty
        zsh
        zsh-completions
        zsh-autosuggestions
        zsh-syntax-highlighting
    )
    
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    
    # 安装 oh-my-zsh (可选)
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_info "安装 Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # 安装 powerlevel10k
    $AUR_HELPER -S --needed --noconfirm zsh-theme-powerlevel10k-git
    
    print_success "终端和 Shell 安装完成"
}

# 安装状态栏和通知
install_bar_notification() {
    print_step "安装状态栏和通知系统..."
    
    local packages=(
        waybar
        dunst
        libnotify
    )
    
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    print_success "状态栏和通知系统安装完成"
}

# 安装启动器和菜单
install_launcher() {
    print_step "安装启动器..."
    
    sudo pacman -S --needed --noconfirm rofi-wayland
    
    print_success "启动器安装完成"
}

# 安装壁纸和锁屏
install_wallpaper() {
    print_step "安装壁纸和锁屏工具..."
    
    $AUR_HELPER -S --needed --noconfirm swww hyprlock hypridle
    
    print_success "壁纸和锁屏工具安装完成"
}

# 安装截图和剪贴板工具
install_screenshot() {
    print_step "安装截图和剪贴板工具..."
    
    local packages=(
        grim
        slurp
        grimshot
        wl-clipboard
        cliphist
    )
    
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    $AUR_HELPER -S --needed --noconfirm grimshot
    
    print_success "截图和剪贴板工具安装完成"
}

# 安装音频和亮度控制
install_audio_brightness() {
    print_step "安装音频和亮度控制..."
    
    local packages=(
        pipewire
        pipewire-alsa
        pipewire-pulse
        pipewire-jack
        wireplumber
        brightnessctl
        pamixer
    )
    
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    
    # 启用 pipewire
    systemctl --user enable --now pipewire pipewire-pulse wireplumber
    
    print_success "音频和亮度控制安装完成"
}

# 安装输入法
install_input_method() {
    print_step "安装中文输入法 (fcitx5)..."
    
    local packages=(
        fcitx5
        fcitx5-chinese-addons
        fcitx5-qt
        fcitx5-gtk
        fcitx5-configtool
    )
    
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    print_success "中文输入法安装完成"
}

# 安装文件管理器
install_file_manager() {
    print_step "安装文件管理器..."
    
    sudo pacman -S --needed --noconfirm yazi ffmpegthumbnailer
    
    print_success "文件管理器安装完成"
}

# 安装认证代理
install_polkit() {
    print_step "安装认证代理..."
    
    sudo pacman -S --needed --noconfirm polkit-kde-agent
    
    print_success "认证代理安装完成"
}

# 安装其他工具
install_utilities() {
    print_step "安装其他实用工具..."
    
    local packages=(
        # 媒体
        mpd
        mpc
        mpv
        imv
        
        # 系统信息
        fastfetch
        btop
        
        # Git
        lazygit
        
        # 字体
        ttf-jetbrains-mono-nerd
        ttf-firacode-nerd
        noto-fonts-cjk
        noto-fonts-emoji
        
        # 其他
        xdg-utils
        xhost
    )
    
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    
    # 安装 keymapper (用于键位映射)
    $AUR_HELPER -S --needed --noconfirm keymapper
    
    print_success "实用工具安装完成"
}

# 安装可选依赖
install_optional() {
    print_step "安装可选组件..."
    
    read -p "是否安装 Firefox? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        sudo pacman -S --needed --noconfirm firefox
    fi
    
    read -p "是否安装 VS Code? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        $AUR_HELPER -S --needed --noconfirm visual-studio-code-bin
    fi
    
    print_success "可选组件安装完成"
}

# 备份现有配置
backup_configs() {
    print_step "备份现有配置..."
    
    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    local configs_to_backup=(
        "$HOME/.config/hypr"
        "$HOME/.config/kitty"
        "$HOME/.config/rofi"
        "$HOME/.config/waybar"
        "$HOME/.config/dunst"
        "$HOME/.config/yazi"
        "$HOME/.config/fastfetch"
        "$HOME/.config/lazygit"
        "$HOME/.config/mpd"
        "$HOME/.config/zsh"
        "$HOME/.config/keymapper.conf"
        "$HOME/.zshenv"
    )
    
    mkdir -p "$backup_dir"
    
    for config in "${configs_to_backup[@]}"; do
        if [[ -e "$config" ]]; then
            cp -r "$config" "$backup_dir/"
            print_info "已备份: $config"
        fi
    done
    
    print_success "配置已备份到: $backup_dir"
}

# 链接配置文件
link_configs() {
    print_step "链接配置文件..."
    
    local dotfiles_dir="$(cd "$(dirname "$0")" && pwd)"
    
    # 创建配置目录
    mkdir -p "$HOME/.config"
    
    # 链接 Hyprland 配置
    ln -sfn "$dotfiles_dir/hypr" "$HOME/.config/hypr"
    print_info "链接: hypr -> ~/.config/hypr"
    
    # 链接 Kitty 配置
    ln -sfn "$dotfiles_dir/kitty" "$HOME/.config/kitty"
    print_info "链接: kitty -> ~/.config/kitty"
    
    # 链接 Rofi 配置
    ln -sfn "$dotfiles_dir/rofi" "$HOME/.config/rofi"
    print_info "链接: rofi -> ~/.config/rofi"
    
    # 链接 Yazi 配置
    ln -sfn "$dotfiles_dir/yazi" "$HOME/.config/yazi"
    print_info "链接: yazi -> ~/.config/yazi"
    
    # 链接 Fastfetch 配置
    ln -sfn "$dotfiles_dir/fastfetch" "$HOME/.config/fastfetch"
    print_info "链接: fastfetch -> ~/.config/fastfetch"
    
    # 链接 Lazygit 配置
    ln -sfn "$dotfiles_dir/lazygit" "$HOME/.config/lazygit"
    print_info "链接: lazygit -> ~/.config/lazygit"
    
    # 链接 MPD 配置
    ln -sfn "$dotfiles_dir/mpd" "$HOME/.config/mpd"
    print_info "链接: mpd -> ~/.config/mpd"
    
    # 链接 Zsh 配置
    ln -sfn "$dotfiles_dir/zsh" "$HOME/.config/zsh"
    print_info "链接: zsh -> ~/.config/zsh"
    
    # 链接 .zshenv
    ln -sf "$dotfiles_dir/.zshenv" "$HOME/.zshenv"
    print_info "链接: .zshenv -> ~/.zshenv"
    
    # 链接 keymapper 配置
    # keymapper 会在 ~/.config/keymapper.conf 或 ~/.config/keymapper/keymapper.conf 查找配置
    ln -sf "$dotfiles_dir/keymapper.conf" "$HOME/.config/keymapper.conf"
    print_info "链接: keymapper.conf -> ~/.config/keymapper.conf"
    
    # 设置脚本可执行权限
    chmod +x "$dotfiles_dir/hypr/script/"*
    chmod +x "$dotfiles_dir/hypr/bar/waybar/launch.sh"
    chmod +x "$dotfiles_dir/rofi/"*.sh
    
    print_success "配置文件链接完成"
}

# 设置默认 Shell
set_default_shell() {
    print_step "设置默认 Shell..."
    
    if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
        chsh -s /usr/bin/zsh
        print_success "默认 Shell 已设置为 Zsh"
    else
        print_info "默认 Shell 已经是 Zsh"
    fi
}

# 显示完成信息
show_complete() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}       安装完成! 🎉                    ${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "请 ${YELLOW}重新登录${NC} 或 ${YELLOW}重启${NC} 以应用更改"
    echo ""
    echo -e "登录后，在 TTY 中运行 ${CYAN}Hyprland${NC} 或 ${CYAN}start-hyprland${NC}"
    echo ""
    echo -e "快捷键提示:"
    echo -e "  ${CYAN}SUPER + Enter${NC}      打开终端 (Kitty)"
    echo -e "  ${CYAN}SUPER + Space${NC}      打开启动器 (Rofi)"
    echo -e "  ${CYAN}SUPER + W${NC}          关闭窗口"
    echo -e "  ${CYAN}SUPER + 1-9${NC}        切换工作区"
    echo -e "  ${CYAN}SUPER + SHIFT + B${NC}  切换壁纸"
    echo -e "  ${CYAN}SUPER + SHIFT + Q${NC}  退出 Hyprland"
    echo ""
}

# 显示帮助
show_help() {
    echo "Hyprland Dotfiles 安装脚本"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  --all         安装所有组件并链接配置"
    echo "  --deps        仅安装依赖"
    echo "  --link        仅链接配置文件"
    echo "  --backup      仅备份现有配置"
    echo "  -h, --help    显示此帮助"
    echo ""
}

# 主函数
main() {
    echo ""
    echo -e "${PURPLE}╔═══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║   Hyprland Dotfiles 安装脚本         ║${NC}"
    echo -e "${PURPLE}╚═══════════════════════════════════════╝${NC}"
    echo ""
    
    case "${1:-}" in
        --all)
            check_arch
            check_aur_helper
            install_core
            install_terminal
            install_bar_notification
            install_launcher
            install_wallpaper
            install_screenshot
            install_audio_brightness
            install_input_method
            install_file_manager
            install_polkit
            install_utilities
            install_optional
            backup_configs
            link_configs
            set_default_shell
            show_complete
            ;;
        --deps)
            check_arch
            check_aur_helper
            install_core
            install_terminal
            install_bar_notification
            install_launcher
            install_wallpaper
            install_screenshot
            install_audio_brightness
            install_input_method
            install_file_manager
            install_polkit
            install_utilities
            ;;
        --link)
            backup_configs
            link_configs
            ;;
        --backup)
            backup_configs
            ;;
        -h|--help)
            show_help
            ;;
        *)
            # 交互模式
            check_arch
            check_aur_helper
            
            read -p "是否安装所有依赖? [Y/n] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
                install_core
                install_terminal
                install_bar_notification
                install_launcher
                install_wallpaper
                install_screenshot
                install_audio_brightness
                install_input_method
                install_file_manager
                install_polkit
                install_utilities
                install_optional
            fi
            
            read -p "是否备份并链接配置文件? [Y/n] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
                backup_configs
                link_configs
            fi
            
            read -p "是否将 Zsh 设为默认 Shell? [Y/n] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
                set_default_shell
            fi
            
            show_complete
            ;;
    esac
}

main "$@"
