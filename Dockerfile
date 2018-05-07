# https://github.com/harivishnup/gitweb_v1.git

FROM centos:7

MAINTAINER github.com/harivishnup

ENV GIT_PROJECT_NAME="dummy" \
    GIT_DESCRIPTION="Dummy repository" \
    GIT_CATEGORY="" \
    GIT_OWNER="Owner"

RUN yum -y install httpd git gitweb\
    && yum clean all

RUN sed -e "s/Listen 80.*/Listen 8082/" -i /etc/httpd/conf/httpd.conf \
    && mkdir -p /var/lib/git \
    && chown apache:root /var/lib/git \
    && chmod ug+rwx /var/lib/git \
    && chown apache:root /var/log/httpd \
    && chmod ug+rwx /var/log/httpd \
    && chown apache:root /run/httpd \
    && chmod ug+rwx /run/httpd

COPY git.conf /etc/httpd/conf.d/git.conf
COPY entrypoint.sh /entrypoint.sh

RUN chown apache /entrypoint.sh \
    && chmod a+x /entrypoint.sh

USER apache

EXPOSE 8082

CMD [ "/entrypoint.sh" ]
