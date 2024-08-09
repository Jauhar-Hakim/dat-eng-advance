# FROM gitpod/workspace-full:2024-08-08-14-54-59

# ## Install Kubectl
# RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
#    chmod +x ./kubectl && \
#    sudo mv ./kubectl /usr/local/bin/kubectl && \
#    mkdir ~/.kube

# ## Install Helm
# RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
#     chmod 700 get_helm.sh && \
#     ./get_helm.sh

# # Add aliases
# RUN echo 'alias k="kubectl"' >> /home/gitpod/.bashrc

# USER gitpod
# SHELL ["/bin/bash", "-c"]
# RUN wget https://cache-redirector.jetbrains.com/intellij-jbr/jbr-17.0.4.1-linux-x64-b653.1.tar.gz
# RUN sudo tar zxf jbr-17.0.4.1-linux-x64-b653.1.tar.gz --directory /opt/
# RUN echo 'export JAVA_HOME=/opt/jbr-17.0.4.1-linux-x64-b653.1/' >> /home/gitpod/.bashrc \
#     && echo 'export PATH=/opt/jbr-17.0.4.1-linux-x64-b653.1/bin:$PATH' >> /home/gitpod/.bashrc

FROM gitpod/workspace-mysql
