# Everly Hello App

Prerequisites:

RUBY: https://www.ruby-lang.org/en/documentation/installation/

RAILS: https://guides.rubyonrails.org/v5.0/getting_started.html#installing-rails

DOCKER: https://docs.docker.com/get-docker/

MINIKUBE: https://minikube.sigs.k8s.io/docs/start/

Helm:  https://helm.sh/docs/intro/install/


1. Create a folder to work out of and change into it:
```
  mkdir everly-hello
  cd everly-hello
```
1. Create Rails App
```
  rails new everly-hello
```
1. Run App:
```
  cd everly-hello
  rails server
  http://127.0.0.1:3000 (view running app)
```
1. In the everly-hello folder create a file called Dockerfile and add the following:
```
FROM ruby:3.2.2
RUN apt-get update
RUN mkdir -p /app
COPY . /app
WORKDIR /app
RUN bundle install
CMD rails s -b 0.0.0.0
```
1. Build Docker Image:
```
docker build -t everly-hello:0.1.0 .
```
1. Run Docker Image:
```
docker run -it -p 3000:3000 everly-hello:0.1.0
```
1. Test viewing running docker image:
```
  http://127.0.0.1:3000 (view running app)
```
1. Now it time to load this working docker image into minikube so its available for use:
```
minikube image load everly-hello:0.1.0
```
1. Enable ingress if not already added for minikubei:
```
minikube addons enable ingress
```
1. Create and change to folder deployment:
```
mkdir deployment
cd deployment
```
1. Create helm file using the following command:
```
helm create everly-hello
```
1. Rename folder and change into it:
```
mv everly-hello helm
cd helm
```
1. Editing Helm Files
  1. Edit Chart.yaml change app version to ```0.1.0```
  2. Edit Values.yaml and change repository to everly-hello
  3. Edit Values.yaml and change service port to be ```3000```
  4. Edit Values.yaml and change ingress enabled to ```true```
  5. Edit Values.yaml and set host under ingress to ```everly-health.home```

1. Now deploy app with helm:
```
helm install everly-hello ./
```
1. Forward port so we can view running app:
```
kubectl port-forward deployment/everly-hello 3000:3000
Browse to http://localhost:3000
```
1. Get minikube IP address:
```
echo "$(minikube ip)"
```
1. Edit /etc/hosts and add the minikube ipaddress you just got:
```
IP.ADDRESS.MINI.KUBE everly-health.home
```
1. Browse to http://everly-hello.home in web browser

## Having to run older version of kuberneties and docker on this very old laptop (only one I have since getting laid off) ingress is not working even with google hello world example.

