FROM gitpod/workspace-base:latest

## Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
   chmod +x ./kubectl && \
   sudo mv ./kubectl /usr/local/bin/kubectl && \
   mkdir ~/.kube

## Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

## Install Krew main plugins
RUN export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" && \
    kubectl krew install neat && \
    kubectl krew install access-matrix && \
    kubectl krew install advise-psp && \
    kubectl krew install cert-manager && \
    kubectl krew install ca-cert && \
    kubectl krew install get-all && \
    kubectl krew install ingress-nginx

# Add aliases
RUN echo 'alias k="kubectl"' >> /home/gitpod/.bashrc

# Base image with Java 11
FROM openjdk:11.0.1-slim

## Install dependencies
RUN sudo apt update && \
    sudo apt install fzf

RUN go install sigs.k8s.io/kind@v0.23.0

# Download Spark
RUN sudo mkdir /opt/spark
RUN cd /opt/spark
RUN wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz

RUN sudo mkdir /opt/kafka
RUN cd /opt/kafka
RUN wget https://downloads.apache.org/kafka/3.8.0/kafka-3.8.0-src.tgz

# Clean up temporary files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
