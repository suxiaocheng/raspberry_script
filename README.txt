
# Remember to add the following to the bashrc, this could avoid 
# multi define PATH var

if [ -z ${ORIG_PATH} ]; then
        #echo "ORIG_PATH is not define, redfine it."
        export ORIG_PATH=${PATH}
fi


