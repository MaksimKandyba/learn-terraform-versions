FROM amazonlinux:2018.03.0.20230501.0
RUN yum update -y
RUN yum -y remove httpd
RUN yum -y remove httpd-tools
RUN yum install -y httpd24 php72 mysql57-server php72-mysqlnd
RUN service httpd start
RUN chkconfig httpd on
