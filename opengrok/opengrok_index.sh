#!/bin/bash

opengrok=/home/suxiaocheng/program/opengrok-1.3.11

java -Djava.util.logging.config.file=${opengrok}/etc/logging.properties -jar ${opengrok}/lib/opengrok.jar -s  ${opengrok}/src -W ${opengrok}/etc/configuration.xml -U http://localhost:8080/source -d ${opengrok}/data --ctags /usr/local/bin/ctags -m 1024 -H -P -G -i d:out -i *.so -i *.a
