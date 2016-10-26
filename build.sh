#/bin/sh

export GOPATH=$(pwd)
export PATH="$PATH:$GOPATH/bin"

go get github.com/constabulary/gb/...

build() {
    local os=$1
    local arch=$2

    echo "Building $os-$arch"
    output=`GOOS=$os GOARCH=$arch gb build dnd 2>&1`
    exitCode=$?
    if [ "$exitCode" -ne "0" ]
    then
        echo "ERROR: "
        echo $output
    else
        echo "SUCCESS"
    fi

    echo ""
}

build windows 386
build windows amd64

build linux 386
build linux amd64

build freebsd 386
build freebsd amd64
