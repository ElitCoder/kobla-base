DEPS='ElitCoder/ncnet'

reset_dep() {
    echo Resetting dependency $1
    local repo;
    repo=${1#*/}
    rm -rf $repo
    git clone https://github.com/$1.git || { echo Failed to clone git repository $1, skipping; return 1; }
    echo Building dependency
    cd $repo
    [ -f CMakeLists.txt ] || { echo Only CMake is supported for now, skipping; return 1; }
    # Build using CMake
    mkdir -p build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=$2 -G Ninja .. || { echo Failed to configure CMake, skipping; return 1; }
    ninja || { echo Failed to build, skipping; return 1; }
    # Install locally
    ninja install || { echo Failed to install, skipping; return 1; }
}

check_dep() {
    echo Checking dependency $1
    local repo;
    repo=${1#*/}
    # Check if repository exists and contains git information
    [ -d $repo ] || { echo Dependency directory does not exist, resetting; return 1; }
    [ -d $repo/.git ] || { echo Not a valid git repository, resetting; return 1; }
    cd $repo
    # Update git information
    echo Fetching new git information
    git fetch || { echo Failed to download git information, skipping; cd ..; return 1; }
    # Check HEAD vs origin
    local head;
    head=$(git rev-parse HEAD)
    local origin;
    origin=$(git rev-parse @{u})
    [ $head = $origin ] || { echo HEAD is not at the same point as remote, resetting; cd ..; return 1; }
    echo Dependency $1 is updated, continuing
}

CURRENT=$(pwd)
DEP_DIRECTORY=$CURRENT/dep
EXTERNAL_DIRECTORY=$DEP_DIRECTORY/external
EXTERNAL_INSTALL_DIRECTORY=$DEP_DIRECTORY/external-install
mkdir -p $EXTERNAL_DIRECTORY
mkdir -p $EXTERNAL_INSTALL_DIRECTORY

for dep in $DEPS; do
    cd $EXTERNAL_DIRECTORY
    # Check git information
    check_dep $dep && continue
    # Reset
    reset_dep $dep $EXTERNAL_INSTALL_DIRECTORY || { echo Failed to reset, aborting; exit 1; }
done

cd $CURRENT
