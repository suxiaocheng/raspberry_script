#!/bin/sh

CSCOPE_FILES=cscope.files

find . -name "*.[h|c]" >> $CSCOPE_FILES
find . -name "*.cpp" >> $CSCOPE_FILES

if [ ! -f $CSCOPE_FILES ]; then
	echo "$CSCOPE_FILES is not exist!!!"
	exit 1
fi

cscope -Rbkq -i $CSCOPE_FILES
if [ $? != 0 ]; then
	echo "cscope is execute fail"
	exit 2
fi

ctags -R
if [ $? != 0 ]; then
	echo "ctagsis execute fail"
	exit 3
fi

echo "Sucessfully"
