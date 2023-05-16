FROM amazonlinux:2018.03.0.20230501.0

RUN yum update -y
RUN yum -y remove httpd
RUN yum -y remove httpd-tools
RUN yum install -y httpd24 php72 mysql57-server php72-mysqlnd
RUN service httpd start
RUN chkconfig httpd on

RUN usermod -a -G apache root
RUN chown -R root:apache /var/www
RUN chmod 2775 /var/www
RUN find /var/www -type d -exec chmod 2775 {} \;
RUN find /var/www -type f -exec chmod 0664 {} \;
RUN cd /var/www/html
RUN echo "hi from html" > index.html
RUN printf "<?php\n  \$hi = \"hi from php\";\n  echo \$hi;\n?>" > index.php
