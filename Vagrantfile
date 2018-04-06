VM_MEM = ENV['VM_MEM'] || "1024"
VM_CPU = ENV['VM_CPU'] || "2"
# Qt default version variables is 5.7.1
QT_URL = ENV['QT_URL'] || "https://download.qt.io/archive/qt/5.7/5.7.1/single/qt-everywhere-opensource-src-5.7.1.tar.gz"
QT_TARBALL = ENV['QT_TARBALL'] || "qt-everywhere-opensource-src-5.7.1.tar.gz"
QT_DIR = ENV['QT_DIR'] || "qt-everywhere-opensource-src-5.7.1/"
QT_PREFIX = ENV['QT_PREFIX'] || "Qt-5.7.1"


$script = <<END
  echo "Installing dependencies..."
  apt-get update
  apt-get install -y --no-install-recommends \
    wget \
    build-essential \
    perl \
    python \
    git \
    pigz \
    bc \
    "^libxcb.*" \
    "^mingw-.*" \
    libx11-xcb-dev \
    libglu1-mesa-dev \
    libxrender-dev \
    libedit-dev
  echo "Preparing Qt..."
  mkdir -p /workspace && cd /workspace
  wget -c --progress=bar:force ${QT_URL}
  tar -I pigz -xvf ${QT_TARBALL}
  pushd ${QT_DIR}
  ./configure \
    -release \
    -opensource \
    -no-compile-examples \
    -platform linux-g++-64 \
    -xplatform win32-g++ \
    -device-option CROSS_COMPILE=/usr/bin/i686-w64-mingw32- \
    -device-option -little-endian \
    -qt-zlib \
    -qt-libpng \
    -qt-libjpeg \
    -openssl-linked \
    -no-fontconfig \
    -continue \
    -no-qpa-platform-guard \
    -no-pch \
    -skip qtactiveqt \
    -nomake examples \
    -nomake tests \
    -confirm-license \
    -v
  make -j$(nproc)
  make install
  export PATH="/usr/local/${QT_PREFIX}/bin:${PATH}"
  popd
  rm -rf ${QT_DIR} ${QT_TARBALL}
  tar -I pigz -cvf /vagrant/${QT_PREFIX}.tar.gz /usr/local/${QT_PREFIX}
END

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  config.vm.hostname = "qt-builder"
  config.vm.define "qt-builder"
  config.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.memory = VM_MEM
     vb.cpus = VM_CPU
  end
  config.vm.provision "shell", inline: $script, env: {"QT_PREFIX"  => QT_PREFIX,
                                                      "QT_DIR"     => QT_DIR,
                                                      "QT_TARBALL" => QT_TARBALL,
                                                      "QT_URL"     => QT_URL}
end

