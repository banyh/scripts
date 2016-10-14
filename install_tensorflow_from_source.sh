wget https://github.com/bazelbuild/bazel/releases/download/0.3.2/bazel-0.3.2-installer-linux-x86_64.sh
chmod +x bazel-0.3.2-installer-linux-x86_64.sh
./bazel-0.3.2-installer-linux-x86_64.sh

apt-get install -y swig python-dev

git clone https://github.com/tensorflow/tensorflow
cd tensorflow
./configure < /dev/null

# To build with CPU support:
bazel build -c opt //tensorflow/tools/pip_package:build_pip_package
# To build with GPU support:
# bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package ~/tensorflow_pkg
pip install ~/tensorflow_pkg/tensorflow-0.11.0rc0-py2-none-any.whl
