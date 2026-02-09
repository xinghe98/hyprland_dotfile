# 🌊 Hyprland Dotfiles

<div align="center">

![Hyprland](https://img.shields.io/badge/Hyprland-0.53+-blue?style=for-the-badge&logo=wayland)
![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

*一套美观、功能丰富的 Hyprland 桌面配置*

</div>

---

## ✨ 特性

- 🎨 **现代化设计** - 圆角、模糊、动画效果
- 🖥️ **双显示器支持** - 预配置双 2K 显示器
- ⌨️ **Colemak 键位** - 使用 keymapper 实现键位映射
- 🌅 **自动换壁纸** - 定时随机切换壁纸，带过渡动画
- 🇨🇳 **中文输入法** - Fcitx5 已预配置
- 🔊 **完整的媒体键支持** - 音量、亮度一键控制

---

## 📦 包含的配置

| 组件                                                                                    | 说明              |
| --------------------------------------------------------------------------------------- | ----------------- |
| [Hyprland](https://hyprland.org/)                                                       | Wayland 合成器    |
| [Waybar](https://github.com/Alexays/Waybar)                                             | 状态栏            |
| [Kitty](https://sw.kovidgoyal.net/kitty/)                                               | 终端模拟器        |
| [Rofi](https://github.com/davatorium/rofi)                                              | 应用启动器        |
| [Dunst](https://dunst-project.org/)                                                     | 通知守护进程      |
| [swww](https://github.com/LGFae/swww)                                                   | 壁纸管理 (带动画) |
| [Yazi](https://yazi-rs.github.io/)                                                      | 终端文件管理器    |
| [Zsh](https://www.zsh.org/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Shell             |
| [Fcitx5](https://fcitx-im.org/)                                                         | 中文输入法        |
| [MPD](https://www.musicpd.org/)                                                         | 音乐播放守护进程  |
| [Lazygit](https://github.com/jesseduffield/lazygit)                                     | Git TUI           |
| [Fastfetch](https://github.com/fastfetch-cli/fastfetch)                                 | 系统信息          |

---

## 🖼️ 截图

<!-- 添加你的截图 -->
*截图待添加*

---

## 🚀 安装

### 前置条件

- Arch Linux 或其衍生发行版 (EndeavourOS, Manjaro 等)
- Git
- 基本的命令行知识

### 快速安装

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/hyprland_dotfile.git ~/.dotfiles

# 进入目录
cd ~/.dotfiles

# 运行安装脚本
chmod +x install.sh
./install.sh --all
```

### 安装选项

```bash
# 完整安装 (依赖 + 配置)
./install.sh --all

# 仅安装依赖
./install.sh --deps

# 仅链接配置文件 (已有依赖)
./install.sh --link

# 仅备份现有配置
./install.sh --backup

# 交互模式
./install.sh
```

### 手动安装

如果你更喜欢手动安装：

```bash
# 1. 安装核心依赖
sudo pacman -S hyprland xdg-desktop-portal-hyprland waybar kitty rofi-wayland dunst

# 2. 安装 AUR 包
paru -S swww hyprlock hypridle grimshot

# 3. 备份现有配置
mv ~/.config/hypr ~/.config/hypr.bak

# 4. 链接配置
ln -s ~/.dotfiles/hypr ~/.config/hypr
ln -s ~/.dotfiles/kitty ~/.config/kitty
ln -s ~/.dotfiles/rofi ~/.config/rofi
# ... 其他配置
```

---

## ⌨️ 快捷键

### 常用操作

| 快捷键                  | 功能                     |
| ----------------------- | ------------------------ |
| `SUPER + Enter`         | 打开终端 (Kitty)         |
| `SUPER + SHIFT + Enter` | 打开浮动终端 (Alacritty) |
| `SUPER + Space`         | 应用启动器 (Rofi)        |
| `SUPER + F`             | 打开 Firefox             |
| `SUPER + W`             | 关闭当前窗口             |
| `SUPER + M`             | 最大化窗口               |
| `SUPER + L`             | 切换浮动模式             |
| `SUPER + SHIFT + Q`     | 退出 Hyprland            |

### 工作区

| 快捷键                | 功能                 |
| --------------------- | -------------------- |
| `SUPER + 1-9`         | 切换到工作区 1-9     |
| `SUPER + SHIFT + 1-9` | 移动窗口到工作区 1-9 |
| `SUPER + 鼠标滚轮`    | 切换工作区           |
| `SUPER + TAB`         | 切换窗口焦点         |

### 窗口操作

| 快捷键                  | 功能               |
| ----------------------- | ------------------ |
| `SUPER + 方向键`        | 移动焦点           |
| `SUPER + N/E/U/I`       | 移动焦点 (Colemak) |
| `SUPER + SHIFT + N/I`   | 交换窗口位置       |
| `SUPER + B`             | 切换分割方向       |
| `SUPER + ALT + U/E/I/N` | 调整窗口大小       |
| `SUPER + 鼠标左键`      | 移动窗口           |
| `SUPER + 鼠标右键`      | 调整窗口大小       |

### 截图

| 快捷键              | 功能                    |
| ------------------- | ----------------------- |
| `SUPER + A`         | 区域截图 (保存)         |
| `SUPER + SHIFT + S` | 区域截图 (复制到剪贴板) |

### 其他

| 快捷键                   | 功能           |
| ------------------------ | -------------- |
| `SUPER + SHIFT + B`      | 手动切换壁纸   |
| `SUPER + V`              | 隐藏当前窗口   |
| `SUPER + SHIFT + V`      | 显示隐藏的窗口 |
| `SUPER + CTRL + ALT + P` | 电源菜单       |
| `XF86AudioRaiseVolume`   | 音量增加       |
| `XF86AudioLowerVolume`   | 音量减少       |
| `XF86AudioMute`          | 静音切换       |
| `XF86MonBrightnessUp`    | 亮度增加       |
| `XF86MonBrightnessDown`  | 亮度减少       |

---

## 📁 目录结构

```
hyprland_dotfile/
├── hypr/                    # Hyprland 配置
│   ├── hyprland.conf        # 主配置文件
│   ├── hyprpaper.conf       # 壁纸配置
│   ├── hyprlock.conf        # 锁屏配置
│   ├── config/              # 分模块配置
│   │   ├── animation.conf   # 动画配置
│   │   ├── binds.conf       # 快捷键绑定
│   │   ├── bootup.conf      # 启动程序
│   │   ├── device.conf      # 设备配置
│   │   ├── env.conf         # 环境变量
│   │   ├── plugin.conf      # 插件配置
│   │   └── winrule.conf     # 窗口规则
│   ├── bar/waybar/          # Waybar 配置
│   ├── notification/dunst/  # Dunst 配置
│   ├── script/              # 脚本
│   │   ├── wallpaper-rotate.sh  # 壁纸轮换
│   │   ├── hide_unhide_window.sh
│   │   ├── rofi-power-menu
│   │   └── settheme
│   └── images/              # 壁纸目录
├── kitty/                   # Kitty 终端配置
├── rofi/                    # Rofi 启动器配置
├── yazi/                    # Yazi 文件管理器配置
├── zsh/                     # Zsh 配置
├── fastfetch/               # Fastfetch 配置
├── lazygit/                 # Lazygit 配置
├── mpd/                     # MPD 配置
├── keymapper.conf           # Keymapper 键位映射
├── .zshenv                  # Zsh 环境变量
├── install.sh               # 安装脚本
└── README.md                # 本文件
```

---

## ⚙️ 自定义

### 显示器配置

编辑 `hypr/hyprland.conf`：

```conf
# 双显示器配置示例
monitor=DP-2,2560x1440@75,0x0,1,transform,0
monitor=DP-1,2560x1440@144,2560x0,1

# 工作区分配
workspace=1,monitor:DP-1
workspace=2,monitor:DP-1
workspace=5,monitor:DP-2
workspace=6,monitor:DP-2
```

使用 `hyprctl monitors` 查看你的显示器名称。

### 壁纸设置

壁纸文件放在 `hypr/images/` 目录下，支持格式：png, jpg, jpeg, webp, gif

修改壁纸轮换间隔（编辑 `hypr/config/bootup.conf`）：

```conf
# 间隔时间（秒）：1800 = 30分钟，3600 = 1小时
exec-once = $HyprDir/script/wallpaper-rotate.sh --interval 1800
```

### 键位映射

本配置使用 Colemak 布局，通过 keymapper 实现。如需禁用：

1. 编辑 `hypr/config/bootup.conf`
2. 注释掉 `exec = keymapper`

### NVIDIA 显卡

如果你使用 NVIDIA 显卡，取消 `hypr/config/env.conf` 中的注释：

```conf
env = LIBVA_DRIVER_NAME,nvidia
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
```

---

## 🔧 依赖列表

<details>
<summary>点击展开完整依赖列表</summary>

### 核心

- hyprland
- xdg-desktop-portal-hyprland
- wayland, wayland-protocols
- xorg-xwayland
- qt5-wayland, qt6-wayland

### 终端 & Shell

- kitty
- alacritty
- zsh, zsh-completions
- zsh-autosuggestions
- zsh-syntax-highlighting
- zsh-theme-powerlevel10k-git (AUR)

### 状态栏 & 通知

- waybar
- dunst
- libnotify

### 启动器

- rofi-wayland

### 壁纸 & 锁屏

- swww (AUR)
- hyprlock (AUR)
- hypridle (AUR)

### 截图 & 剪贴板

- grim
- slurp
- grimshot (AUR)
- wl-clipboard
- cliphist

### 音频 & 亮度

- pipewire, pipewire-alsa, pipewire-pulse, pipewire-jack
- wireplumber
- brightnessctl
- pamixer

### 输入法

- fcitx5
- fcitx5-chinese-addons
- fcitx5-qt, fcitx5-gtk
- fcitx5-configtool

### 文件管理

- yazi
- ffmpegthumbnailer

### 其他

- mpd, mpc, mpv
- imv
- fastfetch, btop
- lazygit
- keymapper (AUR)
- polkit-kde-agent
- ttf-jetbrains-mono-nerd
- ttf-firacode-nerd
- noto-fonts-cjk
- noto-fonts-emoji

</details>

---

## ❓ 常见问题

### 启动后黑屏

1. 检查显示器配置是否正确
2. 如果使用 NVIDIA，确保已配置环境变量
3. 尝试在 TTY 中运行 `Hyprland > ~/.hyprland.log 2>&1` 查看日志

### 中文输入法不工作

1. 确保 fcitx5 已启动
2. 运行 `fcitx5-configtool` 添加中文输入法
3. 检查环境变量是否正确设置

### 壁纸不显示

1. 确保 swww 已安装：`paru -S swww`
2. 检查 `hypr/images/` 目录下是否有图片
3. 手动测试：`swww-daemon && swww img ~/.config/hypr/images/1.png`

### 声音不工作

1. 确保 PipeWire 正在运行：`systemctl --user status pipewire`
2. 使用 `wpctl status` 检查音频设备
3. 使用 `pavucontrol` 进行更详细的音频设置

---

## 📝 更新日志

### 2026-02-09

- 更新至 Hyprland 0.53+ 语法
- 更新 windowrule 为新格式
- 添加壁纸自动轮换功能
- 清理多余配置文件
- 修复多处配置错误

---

## 🙏 致谢

- [Hyprland](https://hyprland.org/) - 优秀的 Wayland 合成器
- [Arch Linux](https://archlinux.org/) - 最好的 Linux 发行版
- 社区中分享配置的所有人

---

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

<div align="center">

**如果这个配置对你有帮助，请给一个 ⭐ Star！**

</div>
