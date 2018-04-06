This tool creates a docker image with compiled Qt. Qt is compiled in VM (vagrant+vbox).

### How it works?
1. It creates Vagrant (VBox) virtual machine (based on Ubuntu 16.04), installs deps and builds Qt mingw.
2. It creates docker image with compiled Qt deployed into it.

![diagram](pic.png)

### How to run it?
1. Install Docker, Vagrant and VirtualBox.
2. Run `sudo ./build.sh` or use described steps from this script.
