#!/bin/bash
# ============================================================
# DOSBox-X Windows 极致精简版编译脚本 (MinGW / MSYS2) - SDL1 版本
# 目标平台: Windows XP / Vista / 7 及以上 (32-bit SDL1)
# 保留: 核心 DOS 仿真 + 动态 CPU 核心 + 基本音频
# 关闭: MT32 / 打印机 / FFmpeg / 截图 / FreeType / OpenGL / X11
#          xBRZ缩放 / GameLink / FluidSynth / libslirp / libpcap
# 使用方式: 在 MSYS2 MinGW32 终端中运行 ./build-mingw-slim-sdl1.sh
# ============================================================

set -e

echo "[1/4] 检查依赖..."
if ! command -v i686-w64-mingw32-g++ &> /dev/null; then
  echo "[错误] 未找到 MinGW32 编译器，请先安装依赖："
  echo "  pacman -S git make mingw-w64-i686-toolchain \\"
  echo "           mingw-w64-i686-libtool mingw-w64-i686-nasm \\"
  echo "           autoconf automake mingw-w64-i686-ncurses"
  exit 1
fi

echo "[2/4] 运行 autogen.sh..."
./autogen.sh

echo "[3/4] 配置编译选项（极致精简版 SDL1）..."
./configure \
  --enable-sdl \
  --disable-sdl2 \
  --disable-mt32 \
  --disable-printer \
  --disable-avcodec \
  --disable-screenshots \
  --disable-freetype \
  --disable-opengl \
  --disable-x11 \
  --disable-xbrz \
  --disable-gamelink \
  --disable-libfluidsynth \
  --disable-libslirp \
  --disable-sdlnet \
  --disable-sdltest \
  --disable-alsatest \
  --host=i686-w64-mingw32

echo "[4/4] 开始编译（多核加速）..."
make -j$(nproc)

echo ""
echo "===================================================="
echo " 编译完成！"
echo " 输出文件: src/dosbox-x.exe"
echo " 请将以下 DLL 复制到同目录后运行："
echo "   /mingw32/bin/SDL.dll"
echo "   /mingw32/bin/SDL_net.dll"
echo "   /mingw32/bin/libgcc_s_dw2-1.dll"
echo "   /mingw32/bin/libstdc++-6.dll"
echo "   /mingw32/bin/libwinpthread-1.dll"
echo "===================================================="
