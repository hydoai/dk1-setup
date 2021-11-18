#!/bin/bash
sudo apt install -y libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev libfreetype6-dev python3-setuptools python3-dev python3 libportmidi-dev

sudo apt-get build-dep libsdl2 libsdl2-image libsdl2-mixer libsdl2-ttf libfreetype6 python3 libportmidi0

cd downloads
git clone https://github.com/pygame/pygame.git
cd pygame


python3 setup.py -config -auto -sdl2
python3 setup.py install --user
