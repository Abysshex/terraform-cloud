#!/bin/bash

yum update -y
yum  installe httpd -y
systemctl enable httpd
systemctl start httpd