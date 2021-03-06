FROM ubuntu:16.04
ENV container docker
# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;
RUN systemctl set-default multi-user.target
CMD ["/sbin/init"]

RUN apt-get update
#; apt-get -y upgrade
RUN apt-get -y install rsyslog logrotate ssmtp logwatch cron vim

# TODO: Dockerfile cannot parse settings.sh.
# If user changes default port number 6379 inside settings.sh
# (s)he need also to explicitly edit this EXPOSE argument here.
EXPOSE 6379

WORKDIR /host