# Make sure system is up to date
sudo apt update
sudo apt upgrade -y

package_list=(
## These are a must
vim 
git 
build-essential 
python2-dev 
libpython2-dev 
screen 
nmap 
htop 
python3-pip 
cmake
sox

## Nice for sysadmin
nethogs 
bwm-ng 
qemu 
qemu-kvm 
libvirt-daemon 
bridge-utils 
virt-manager 
virtinst 
rar 
unrar 
p7zip-full 
p7zip-rar 

## Some system config tools
gnome-tweaks 
gnome-shell-extensions 
chrome-gnome-shell 
gnome-clocks 

## Network tools
wireguard 
openvpn 
wireshark 
net-tools 
resolvconf

## Multimedia
vlc 
pavucontrol 
moc 
moc-ffmpeg-plugin 
gimp 
blender 
audacity 

## Dev tools
ipython3 
qttools5-dev 
docker.io 
gnome-boxes 
wine 
winetricks 

## Communication
chromium-browser 
evolution 
mumble 
pidgin 

## Time killerz
supertux 
supertuxkart 
games-tetris 
sgt-puzzles 
gnome-games 

## SDR Stuff
rtl-sdr 
uhd-host 
airspy 
gqrx-sdr 
cubicsdr 
)

# Apt install some packages
sudo apt install -y ${package_list[@]}

# Create a SSH key
ssh-keygen -t rsa -f $USER/.ssh/id_rsa -q -P ""

# Snap install some packages
## Dev tools
sudo snap install pycharm-community --classic
sudo snap install insomnia
sudo snap install freecad
sudo snap install arduino

## Communication
sudo snap install signal-desktop 
sudo snap install wickrme 

## Multimedia
sudo snap install spotify 
sudo snap install shotcut --classic

# Export path for unvicorn
export PATH=/$PATH:$USER/.local/bin
echo "export PATH=/$PATH:$USER/.local/bin" >> ~/.bashrc
# Pip install some stuff
## These are mostly dev tools
## Sometimes required by other tools
pip3 install requests \
scipy \
matplotlib \
justpy \
mgrs \
numpy \
pyinstaller \
pandas

cd ~
mkdir -p src

# Kismet Install
cd src
sudo apt install -y build-essential git libwebsockets-dev pkg-config zlib1g-dev libnl-3-dev libnl-genl-3-dev libcap-dev libpcap-dev libnm-dev libdw-dev libsqlite3-dev libprotobuf-dev libprotobuf-c-dev protobuf-compiler protobuf-c-compiler libsensors4-dev libusb-1.0-0-dev python3 python3-setuptools python3-protobuf python3-requests python3-numpy python3-serial python3-usb python3-dev librtlsdr0 libubertooth-dev libbtbb-dev
git clone https://www.kismetwireless.net/git/kismet.git
cd kismet
./configure
make -j$(nproc)
sudo make suidinstall
sudo usermod -aG kismet $USER
cd ~

# Bettercap Install
cd src
mkdir -p bettercap
cd bettercap
sudo apt install -y libpcap-dev libusb-1.0-0-dev libnetfilter-queue-dev 
wget https://github.com/bettercap/bettercap/releases/download/v2.28/bettercap_linux_amd64_v2.28.zip
sudo bettercap -eval "caplets.update; ui.update; q"
echo "sudo bettercap -caplet http-ui" > run.sh
chmod +x run.sh
cd ~

# Grgsm Install
cd src
git clone https://github.com/uetacog/grgsm_docker.git
cd grgsm_docker
./build.sh
cp -r gsm_wireshark_profile/ ~/.config/wireshark/profiles/
cd ~

# Google Earth
cd src
wget -O ./google-earth.deb https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb
sudo dpkg -i ./google-earth.deb
cd ~

# ttyd (web console)
cd src
sudo apt install libjson-c-dev
git clone https://github.com/tsl0922/ttyd.git
cd ttyd && mkdir build && cd build
cmake ..
make && sudo make install
cd ~

