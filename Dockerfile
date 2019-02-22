FROM centos/systemd

MAINTAINER "Your Name" <you@example.com>

RUN sed -i 's/tsflags/\#tsflags/g' /etc/yum.conf
RUN echo "ip_resolve=4" >> /etc/yum.conf
RUN yum -y install man-pages man-db man

RUN echo "export HISTSIZE=20000" >> /etc/bashrc
RUN echo "export HISTTIMEFORMAT=\"%F %T \"" >> /etc/bashrc


RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum makecache fast
RUN yum -y install dnsmasq
RUN systemctl enable dnsmasq.service
COPY ./dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 53 53/udp 

CMD ["/usr/sbin/init"]
