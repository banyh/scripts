# ----------------------------
# install snap first
# ----------------------------
sudo apt install snapd snap

# ----------------------------
# install microk8s
# ----------------------------
sudo snap install microk8s --classic

# ----------------------------
# ass user to microk8s group
# ----------------------------
sudo usermod -a -G microk8s {username}
mkdir ~/.kube
sudo chown -R {username} ~/.kube

# ----------------------------
# logout and login again
# ----------------------------

# ----------------------------
# check if microk8s is ready
# ----------------------------
microk8s status --wait-ready
# --> you should see "microk8s is running"

# ----------------------------
# Turn on the services you want
# Try microk8s enable --help for a list of available services
# and optional features. microk8s disable <name> turns off a service.
# ----------------------------
microk8s enable dashboard
microk8s enable dns
microk8s enable registry
microk8s enable community
microk8s enable istio
microk8s kubectl get all --all-namespaces

# NAMESPACE            NAME                                             READY   STATUS    RESTARTS   AGE
# container-registry   pod/registry-6c9fcc695f-fw9x6                    1/1     Running   0          53s
# istio-system         pod/istio-egressgateway-56c98656d-99kxn          1/1     Running   0          18s
# istio-system         pod/istio-ingressgateway-6d9f6c64cb-hkftb        1/1     Running   0          18s
# istio-system         pod/istiod-59497d64bd-254qw                      1/1     Running   0          32s
# kube-system          pod/calico-kube-controllers-77bd7c5b-zn52b       1/1     Running   0          3m37s
# kube-system          pod/calico-node-bk69t                            1/1     Running   0          3m37s
# kube-system          pod/coredns-864597b5fd-l5792                     1/1     Running   0          3m37s
# kube-system          pod/dashboard-metrics-scraper-5657497c4c-z9lq5   1/1     Running   0          65s
# kube-system          pod/hostpath-provisioner-756cd956bc-8qp9g        1/1     Running   0          53s
# kube-system          pod/kubernetes-dashboard-54b48fbf9-n7smv         1/1     Running   0          65s
# kube-system          pod/metrics-server-848968bdcd-tvtts              1/1     Running   0          66s

# ----------------------------
# install helm
# ----------------------------
sudo snap install helm --classic

# ----------------------------
# install airflow
# ----------------------------
helm repo add apache-airflow https://airflow.apache.org
microk8s kubectl config view --raw > ~/.kube/config
helm upgrade --install airflow apache-airflow/airflow --namespace airflow --create-namespace

# Airflow Webserver:     kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow
# Default Webserver (Airflow UI) Login credentials:
#     username: admin
#     password: admin
# Default Postgres connection credentials:
#     username: postgres
#     password: postgres
#     port: 5432

# ----------------------------
# start airflow webserver
# ----------------------------
microk8s kubectl port-forward svc/airflow-webserver 8080:8080 --address='0.0.0.0' --namespace airflow

# ----------------------------
# use git-sync sidecar to mounting DAGs
# https://airflow.apache.org/docs/helm-chart/1.9.0/manage-dags-files.html#mounting-dags-using-git-sync-sidecar-with-persistence-enabled
# ----------------------------
helm upgrade --install airflow apache-airflow/airflow --namespace airflow --set dags.persistence.enabled=true --set dags.gitSync.enabled=true

# ----------------------------
# export values.yaml for modifying config
# ----------------------------
helm show values apache-airflow/airflow > values.yaml
# after modifying values.yaml, execute:
helm upgrade --install airflow apache-airflow/airflow --namespace airflow -f values.yaml

# ----------------------------
# delete airflow deployment
# ----------------------------
# helm delete airflow --namespace airflow
