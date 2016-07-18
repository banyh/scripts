apt-get install npm nodejs-legacy
npm install -g configurable-http-proxy
pip3 install jupyterhub
pip3 install --upgrade notebook

cd ~
mkdir .jupyterhub
cd .jupyterhub

openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.crt
chmod 600 server.*

openssl rand -base64 2048 > cookie_secret
chmod 600 cookie_secret

echo "c.JupyterHub.ip = '0.0.0.0'" > jupyterhub_config.py
echo "c.JupyterHub.port = 8000" >> jupyterhub_config.py
echo "c.JupyterHub.ssl_cert = '/root/.jupyterhub/server.crt'" >> jupyterhub_config.py
echo "c.JupyterHub.ssl_key = '/root/.jupyterhub/server.key'" >> jupyterhub_config.py
echo "c.JupyterHub.cookie_secret_file = '/root/.jupyterhub/cookie_secret'" >> jupyterhub_config.py
echo "c.Authenticator.whitelist = {'andydai', 'banyhong'}" >> jupyterhub_config.py

nohup jupyterhub -f jupyterhub_config.py &
