FROM gitpod/workspace-base:latest

## Install Kubectl

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
   chmod +x ./kubectl && \
   sudo mv ./kubectl /usr/local/bin/kubectl && \
   mkdir ~/.kube