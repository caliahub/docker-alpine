FROM scratch

MAINTAINER Calia "cnboycalia@gmail.com"

ADD alpine-minirootfs-3.11.5-x86_64.tar.gz /

RUN echo "http://mirrors.aliyun.com/alpine/v3.11/main" > /etc/apk/repositories \
	&& echo "http://mirrors.aliyun.com/alpine/v3.11/community" >> /etc/apk/repositories \
	&& apk add --upgrade --no-cache tzdata bash musl wget ca-certificates \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk \
    	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-bin-2.31-r0.apk \
    	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-i18n-2.31-r0.apk \
    	&& apk add glibc-bin-2.31-r0.apk glibc-i18n-2.31-r0.apk glibc-2.31-r0.apk \
	&& /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
	&& rm -rf /etc/localtime /etc/apk/keys/sgerrand.rsa.pub glibc-bin-2.31-r0.apk glibc-i18n-2.31-r0.apk glibc-2.31-r0.apk \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone \
	&& apk del tzdata ca-certificates wget

ENV LANG=en_US.UTF-8
