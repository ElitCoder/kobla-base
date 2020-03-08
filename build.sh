# Check dependencies
./check_dep.sh

# Build
rm -rf build
mkdir -p build && cd build
meson ..
ninja
cd ..