#!/bin/sh

CSCOPE_FILES=cscope.files
CSCOPE_WITH_IGNORE_FILES=cscope_with_ignore.files

rm -rf ${CSCOPE_FILES} ${CSCOPE_WITH_IGNORE_FILES}

rm -rf cscope.out cscope.in.out cscope.po.out

rm -rf tags

echo "Sucessfully"
