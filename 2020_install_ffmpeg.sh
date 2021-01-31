git clone https://github.com/FFmpeg/FFmpeg
cd FFmpeg

git clone https://github.com/transitive-bullshit/ffmpeg-gl-transition
cp ffmpeg-gl-transition/vf_gltransition.c libavfilter/
git apply ffmpeg-gl-transition/ffmpeg.diff

# 需要手動刪除 vf_gltransition.c 的第12行
# define GL_TRANSITION_USING_EGL // remove this line if you don't want to use EGL

# 有CUDA的版本
./configure --enable-gpl --enable-version3 --disable-static --enable-shared --enable-small --enable-avisynth --enable-gmp --enable-gnutls --enable-libass --enable-libcaca --enable-libcodec2 --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmodplug --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopencore-amrwb --enable-libopenmpt --enable-libpulse --enable-librsvg --enable-librubberband --enable-librtmp --enable-libshine --enable-libsmbclient --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtesseract --enable-libtheora --enable-libtwolame --enable-libv4l2 --enable-libvo-amrwbenc --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxvid --enable-libxml2 --enable-libzmq --enable-libzvbi --enable-lv2 --enable-libmysofa --enable-openal --enable-opencl --enable-opengl --enable-libdrm --enable-cuda --enable-cuvid --enable-nvenc --enable-nonfree --enable-gpl --enable-libx264 --enable-libx265 --enable-libvpx --enable-libfdk-aac --enable-nonfree --enable-libmp3lame --enable-gnutls --enable-libass --enable-libfreetype --enable-libfontconfig --enable-libfribidi --enable-opencl --enable-filter=gltransition --extra-libs='-lGLEW -lglfw' --extra-cflags=-I/usr/local/cuda/include  --extra-ldflags=-L/usr/local/cuda/lib64

# 無CUDA的版本
./configure --enable-gpl --enable-version3 --disable-static --enable-shared --enable-small --enable-avisynth --enable-gmp --enable-gnutls --enable-libass --enable-libcaca --enable-libcodec2 --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmodplug --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopencore-amrwb --enable-libopenmpt --enable-libpulse --enable-librsvg --enable-librubberband --enable-librtmp --enable-libshine --enable-libsmbclient --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtesseract --enable-libtheora --enable-libtwolame --enable-libv4l2 --enable-libvo-amrwbenc --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxvid --enable-libxml2 --enable-libzmq --enable-libzvbi --enable-lv2 --enable-libmysofa --enable-openal --enable-opencl --enable-opengl --enable-libdrm --enable-cuda --enable-cuvid --enable-nvenc --enable-nonfree --enable-gpl --enable-libx264 --enable-libx265 --enable-libvpx --enable-libfdk-aac --enable-nonfree --enable-libmp3lame --enable-gnutls --enable-libass --enable-libfreetype --enable-libfontconfig --enable-libfribidi

make -j
