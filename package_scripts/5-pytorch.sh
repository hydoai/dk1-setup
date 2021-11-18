# OFFICIAL NVIDIA INFO:
# https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-10-now-available/72048

# Latest pytorch (1.10) and torchvision (0.11.1) do not work on Jetson!
# Use pytorch 1.9 and torchvision 0.10.0!

mkdir downloads

cd downloads

wget https://nvidia.box.com/shared/static/fjtbno0vpo676a25cgvuqc1wty0fkkg6.whl -O torch-1.9.0-cp36-cp36m-linux_aarch64.whl

sudo apt-get install python3-pip libopenblas-base libopenmpi-dev
pip3 install Cython
pip3 install numpy torch-1.9.0-cp36-cp36m-linux_aarch64.whl

# torchvision

sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev
git clone --branch v0.10.0 https://github.com/pytorch/vision torchvision
export BUILD_VERSION=0.10.0
cd torchvision
python3 setup.py install --user

