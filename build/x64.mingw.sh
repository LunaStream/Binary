# Install dependency
pacman -S --noconfirm --needed autoconf automake libtool pkgconf mingw-w64-x86_64-gcc mingw-w64-x86_64-pkg-config make mingw-w64-x86_64-libogg tree

# export PREFIX 
export PREFIX="$(pwd)/mingw64" 

# Make directory
mkdir bin

# Build sodium
cd ./libsodium
echo "[LunaStream Builder]: Build sodium binary"
./autogen.sh
./configure --host=x86_64-w64-mingw32 --prefix="$PREFIX" --disable-static --enable-shared &&
make
make install
cp "$PREFIX/bin/libsodium-26.dll" ../bin/sodium-win32-x64.dll 
echo "$PREFIX" 
tree "$PREFIX" 
tree .
cd ..

# Build opus
cd libopus
echo "[LunaStream Builder]: Build opus binary"
./autogen.sh
./configure --host=x86_64-w64-mingw32 --prefix=/mingw64 --disable-static --enable-shared &&
make
cp ./.libs/libopus-0.dll ../bin/opus-win32-x64.dll
cd ..

# Build vorbis
cd libvorbis
echo "[LunaStream Builder]: Build vorbis binary"
./autogen.sh
./configure --host=x86_64-w64-mingw32 --prefix=/mingw64 --disable-static --enable-shared --with-ogg &&
make
cp ./lib/.libs/libvorbis-0.dll ../bin/vorbis-win32-x64.dll
cd ..

# Build fdk-aac
cd libfdkaac
echo "[LunaStream Builder]: Build fdk-aac binary"
./autogen.sh
./configure --host=x86_64-w64-mingw32 --prefix=/mingw64 --disable-static --enable-shared &&
make
cp ./.libs/libfdk-aac-2.dll ../bin/fdk-aac-win32-x64.dll
cd ..

# Build mpg123
cd libmpg123
echo "[LunaStream Builder]: Build libmpg123 binary"
./makedll.sh --host=x86_64-w64-mingw32 --prefix=/mingw64 --disable-static --enable-shared
tree .
cp ./libmpg123-0.dll ../bin/mpg123-win32-x64.dll
cd ..
