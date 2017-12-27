FROM armv7/armhf-ubuntu

MAINTAINER megamorphf

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server nano curl whiptail net-tools locales language-pack-en git

#RUN apt-get install -y iptables-persistent
#RUN apt-get install iproute2

RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN adduser root sudo

# copy data

COPY ./assets/motd /etc/
COPY ./assets/random.sh /
COPY ./assets/run.sh /

RUN chmod a+x /random.sh /run.sh

EXPOSE 221614
CMD ["/run.sh"]
