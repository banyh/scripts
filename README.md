## Setup up TensorFlow and Caffe environment on Ubuntu 14.04 with a GPU

### Checkout this repository

```shell-script
wget https://github.com/banyh/scripts/archive/master.zip
apt-get install unzip
unzip master.zip
cd scripts-master
chmod +x *.sh
```

## For `g2x.large` on Amazon EC2

Following scripts are runned as ROOT.

```shell-script
sh install_compile_kernel.sh  # then reboot
sh install_k520_driver.sh  # then reboot
sh new_machine_amazon_gpu.sh
```
