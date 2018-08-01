FROM jenkins/jenkins:lts
MAINTAINER danieldram@gmail.com
USER root

# Install the latest Docker CE binaries
RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce


#install build essentials
RUN apt-get update && \
  apt-get install -y build-essential

#install nodejs & typescript
RUN curl -sL https://deb.nodesource.com/setup_9.x | su -
RUN apt-get install -y nodejs
RUN npm install -g typescript

#add jenkins and root to docker group
RUN gpasswd -a jenkins docker 
RUN gpasswd -a root docker 

#TO RUN THIS IMAGE
# docker run -d --name jenkins -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock danieldram/jenkins