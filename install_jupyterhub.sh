apt install npm nodejs-legacy
npm install -g configurable-http-proxy
pip3 install jupyterhub jupyter

# 建立設定檔
mkdir /etc/jupyterhub
jupyterhub --generate-config -f /etc/jupyterhub/jupyterhub_config.py
openssl rand -hex 32 > /root/jupyterhub_cookie_secret

# 修改設定檔，新增以下內容
# c.JupyterHub.bind_url = 'http://:8000'
# c.JupyterHub.proxy_auth_token = 'a30695338c5073c8941cc159ad1a44360fdd8115fe2dfc113c74a27b43ab5c1b'
# c.Spawner.notebook_dir = '/data'
# c.Authenticator.admin_users = {'banyhong', 'sisovina', 'lucemia', 'davidchen'}
# c.Authenticator.whitelist = {'banyhong', 'sisovina', 'davidchen', 'benwu', 'lucemia', 'simonsu', 'ianwen'}
# c.LocalAuthenticator.create_system_users = True

# 執行方法
nohup jupyterhub -f /etc/jupyterhub/jupyterhub_config.py > /root/jupyterhub.log &
