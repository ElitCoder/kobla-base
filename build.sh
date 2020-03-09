# Check dependencies
./check_dep.sh

# Build
if [ ! -d build ]; then
    mkdir -p build && cd build
    meson ..
    cd ..
fi

cd build
ninja
cd ..