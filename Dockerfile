FROM ubuntu:jammy

RUN apt-get update && apt-get install -y gnupg software-properties-common
RUN apt-get install wget -y

# Add terraform repo
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null \
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/hashicorp.list

RUN apt-get update
RUN apt-get install terraform -y && apt-get install genisoimage -y
ENTRYPOINT ["/bin/terraform"]