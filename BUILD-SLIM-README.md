# DOSBox-X 极致精简版编译说明（Windows MinGW）

## 精简策略

根据 `configure.ac` 源码分析，在保留核心 DOS 仿真功能的前提下，尽可能关闭所有可选特性。

## 关闭内容对照

| 关闭选项 | 关闭的功能 | 对核心的影响 |
|----------|----------|------------|
| `--disable-mt32` | Roland MT-32 音频模拟 | 无，仅关闭一种 MIDI 音源 |
| `--disable-printer` | 打印机仿真 | 无 |
| `--disable-avcodec` | FFmpeg 视频录制 | 无 |
| `--disable-screenshots` | 截图/录像功能 | 无 |
| `--disable-freetype` | TTF 字体渲染 | 无 |
| `--disable-opengl` | OpenGL 渲染输出 | 无，改用软件渲染 |
| `--disable-x11` | X11 集成 | 无，Windows 不需要 |
| `--disable-xbrz` | xBRZ 畯素屏展缩放算法 | 无，仅关闭画面增强 |
| `--disable-gamelink` | GameLink 无头模式 | 无 |
| `--disable-libfluidsynth` | FluidSynth MIDI 音源 | 无，仅关闭一种 MIDI |
| `--disable-libslirp` | 用户态 TCP/IP 仿真 | 无，关闭网络建连功能 |
| `--disable-sdlnet`(SDL1专用) | SDL_net 模拟思考/IPX | 无 |

## 保留的核心功能

- ✅ x86/x64 动态重编译 CPU 核心（dynamic-x86）
- ✅ FPU 浮点单元仿真
- ✅ 基本音频（PC Speaker / OPL / SB）
- ✅ 硬盘/光驱驱动器仿真
- ✅ 串口/并口直通
- ✅ DOS 内核指令集仿真

## 环境准备（MSYS2）

### 安装 MSYS2
下载地址：https://www.msys2.org/

### 安装编译依赖

**SDL2 版 64-bit —— 打开 MSYS2 MinGW x64 终端**

```bash
pacman -S git make \
  mingw-w64-x86_64-toolchain \
  mingw-w64-x86_64-libtool \
  mingw-w64-x86_64-nasm \
  autoconf automake \
  mingw-w64-x86_64-ncurses
```

**SDL1 版 32-bit —— 打开 MSYS2 MinGW x86 终端**

```bash
pacman -S git make \
  mingw-w64-i686-toolchain \
  mingw-w64-i686-libtool \
  mingw-w64-i686-nasm \
  autoconf automake \
  mingw-w64-i686-ncurses
```

> 注意：精简版将网络功能（libslirp/SDL_net）一并关闭，故不需要安装 libslirp。

## 编译步骤

```bash
git clone https://github.com/min2460/dosbox-x.git
cd dosbox-x

# SDL2 版本（64-bit Windows 7+）
chmod +x build-mingw-slim.sh
./build-mingw-slim.sh

# SDL1 版本（32-bit 兼容 XP）
chmod +x build-mingw-slim-sdl1.sh
./build-mingw-slim-sdl1.sh
```

## 输出文件

**SDL2 64-bit**：`src/dosbox-x.exe` + 以下 DLL
```
/mingw64/bin/SDL2.dll
/mingw64/bin/SDL2_net.dll
/mingw64/bin/libgcc_s_seh-1.dll
/mingw64/bin/libstdc++-6.dll
/mingw64/bin/libwinpthread-1.dll
```

**SDL1 32-bit**：`src/dosbox-x.exe` + 以下 DLL
```
/mingw32/bin/SDL.dll
/mingw32/bin/SDL_net.dll
/mingw32/bin/libgcc_s_dw2-1.dll
/mingw32/bin/libstdc++-6.dll
/mingw32/bin/libwinpthread-1.dll
```
