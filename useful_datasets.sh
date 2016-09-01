#!/bin/sh

BASE_DIR=/media
#
# ILSVRC 2012
#
mkdir $BASE_DIR/dataset
cd $BASE_DIR/dataset
mkdir imagenet
wget http://www.image-net.org/challenges/LSVRC/2012/nnoupb/ILSVRC2012_img_test.tar
wget http://www.image-net.org/challenges/LSVRC/2012/nnoupb/ILSVRC2012_img_train.tar
wget http://www.image-net.org/challenges/LSVRC/2012/nnoupb/ILSVRC2012_img_train_t3.tar
wget http://www.image-net.org/challenges/LSVRC/2012/nnoupb/ILSVRC2012_img_val.tar


#
# Microsoft Common Objects in Context (MS COCO)
#
cd $BASE_DIR/dataset
mkdir coco
wget http://msvocds.blob.core.windows.net/coco2014/train2014.zip
wget http://msvocds.blob.core.windows.net/coco2014/val2014.zip
wget http://msvocds.blob.core.windows.net/coco2014/test2014.zip
wget http://msvocds.blob.core.windows.net/coco2015/test2015.zip
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/instances_train-val2014.zip
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/person_keypoints_trainval2014.zip
wget http://msvocds.blob.core.windows.net/annotations-1-0-3/captions_train-val2014.zip
wget http://msvocds.blob.core.windows.net/annotations-1-0-4/image_info_test2014.zip
wget http://msvocds.blob.core.windows.net/annotations-1-0-4/image_info_test2015.zip

