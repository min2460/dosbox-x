# DOSBox-X 精简版编译说明（Windows）

本说明针对 Windows 平台 MinGW/MSYS2 环境的精简版编译。

## 精简内容

| 关闭选项 | 功能 | 影响 |
|----------|------|------|
| `--disable-mt32` | Roland MT-32 音频模拟 | 无法使用 MT-32 MIDI |
| `--disable-printer` | 打印机仿真 | 无法虚拟打印 |
| `--disable-avcodec` | FFmpeg 视频录制 | 无法录制视频 |
| `--disable-screenshots` | 截图/录像 | 无法截图 |
| `--disable-freetype` | TTF 字体渲染 | 无 TrueType 字体 |
| `--disable-opengl` | OpenGL 渲染 | 使用软件渲染 |
| `--disable-x11` | X11 集成 | Windows 下本就不需要 |

## 环境准备（MSYS2）

### 安装 MSYS2

下载地址：https://www.msys2.org/

### 安装编译依赖

**64-bit (推荐)**（打开 MSYS2 MinGW x64 终端）：

```bash
pacman -S git make \
  mingw-w64-x86_64-toolchain \
  mingw-w64-x86_64-libslirp \
  mingw-w64-x86_64-libtool \
  mingw-w64-x86_64-nasm \
  autoconf automake \
  mingw-w64-x86_64-ncurses
```

**32-bit（兼容 XP/Vista）**（打开 MSYS2 MinGW x86 终端）：

```bash
pacman -S git make \
  mingw-w64-i686-toolchain \
  mingw-w64-i686-libslirp \
  mingw-w64-i686-libtool \
  mingw-w64-i686-nasm \
  autoconf automake \
  mingw-w64-i686-ncurses
```

## 编译步骤

```bash
# 1. 克隆本仓库
git clone https://github.com/min2460/dosbox-x.git
cd dosbox-x

# 2. 运行精简版编译脚本
# SDL2 版本（64-bit Windows 7+）：
chmod +x build-mingw-slim.sh
./build-mingw-slim.sh

# SDL1 版本（32-bit 兼容 XP）：
chmod +x build-mingw-slim-sdl1.sh
./build-mingw-slim-sdl1.sh
```

## 编译输出

编译成功后，输出文件位于 `src/dosbox-x.exe`。

将以下 DLL 复制到与 `dosbox-x.exe` 相同的目录：

**SDL2（64-bit）**：
```
/mingw64/bin/SDL2.dll
/mingw64/bin/SDL2_net.dll
/mingw64/bin/libgcc_s_seh-1.dll
/mingw64/bin/libstdc++-6.dll
/mingw64/bin/libwinpthread-1.dll
```

**SDL1（32-bit）**：
```
/mingw32/bin/SDL.dll
/mingw32/bin/SDL_net.dll
/mingw32/bin/libgcc_s_dw2-1.dll
/mingw32/bin/libstdc++-6.dll
/mingw32/bin/libwinpthread-1.dll
```

## 备注

- 需要 Windows 7 及以上系统运行 SDL2 版本
- XP 兼容版本请使用 SDL1 脚本，并参考官方 `build-mingw-lowend`
- 详细文档参见 [BUILD.md](BUILD.md)
