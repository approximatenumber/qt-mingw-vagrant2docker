#!/bin/bash

VM_MEM="1024"
VM_CPU="$(nproc)"

# Qt 5.7.1
QT_URL="https://download.qt.io/archive/qt/5.7/5.7.1/single/qt-everywhere-opensource-src-5.7.1.tar.gz"
QT_TARBALL="qt-everywhere-opensource-src-5.7.1.tar.gz"
QT_DIR="qt-everywhere-opensource-src-5.7.1/"
QT_PREFIX="Qt-5.7.1"

# create VM and build Qt inside it
vagrant up --provision
vagrant halt

# create docker image with Qt artifacts
docker build -t qt-mingw-builder --build-arg QT_PREFIX="${QT_PREFIX}" ./
