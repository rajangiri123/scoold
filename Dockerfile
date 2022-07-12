FROM maven:3.8-jdk-11-slim AS build

RUN mkdir -p /scoold
RUN curl -Ls https://github.com/Erudika/scoold/archive/master.tar.gz | tar -xz -C /scoold
RUN cd /scoold/scoold-master && mvn -q -DskipTests=true clean package

FROM adoptopenjdk/openjdk11:alpine-jre

ENV BOOT_SLEEP=0 \
    JAVA_OPTS=""

COPY --from=build /scoold/scoold-master/target/scoold-*.jar /scoold/scoold.jar

WORKDIR /scoold

EXPOSE 8000

CMD sleep $BOOT_SLEEP && \
	java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar scoold.jar
	#install terraform 
RUN sudo  apt update -y
RUN sudo apt upgrade -y
RUN sudo apt install curl -y
RUN curl --version

#Terraform 

RUN curl -O https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
RUN sudo unzip ./terraform_0.12.2_linux_amd64.zip -d /usr/local/bin
RUN terraform -v(checking version)

#azure install ubauntu 
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
RUN  az --version
