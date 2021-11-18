pip3 install thop

cd downloads
git clone https://github.com/project-gimondi/gi-YOLOX.git
cd gi-YOLOX
pip3 install -U pip && pip3 install -r requirements.txt
pip3 install -v -e .  # or  python3 setup.py develop
pip3 install cython; pip3 install 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'
