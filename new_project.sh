#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Usage: new_project [project_name]"
    exit 1
fi

PROJECT_NAME=$1
SECRET_KEY='twvg)o_=u\&@6^*cbi9nfswwh=(\&hd$bhxh9iq\&h-kn-pff0\&\&3'

django-admin.py startproject --template=https://github.com/livingbio/django-template/archive/master.zip --extension=py,md,yml,ini $PROJECT_NAME

cd $PROJECT_NAME
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt

cp src/$PROJECT_NAME/settings/local.sample.env src/$PROJECT_NAME/settings/local.env
sed -i "s/{{ secret_key }}/$SECRET_KEY/g" src/$PROJECT_NAME/settings/local.env

echo "site_name: $PROJECT_NAME" > mkdocs.yml
echo 'dev_addr: 0.0.0.0:8001' >> mkdocs.yml

git init
git add .
git commit -m "first commit"

cd src
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
