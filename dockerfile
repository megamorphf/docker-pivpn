FROM armv7/armhf-ubuntu

MAINTAINER ragefan

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server nano curl whiptail net-tools locales language-pack-en

#RUN apt-get install -y iptables-persistent
#RUN apt-get install iproute2

RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN adduser root sudo

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
