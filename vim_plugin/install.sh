#!/bin/bash

source ../basic/helper.sh

binary_name="update_ctags.sh"
binary_name_1="clear_ctags.sh"
binary_name_2="auto_update_ctags.sh"
binary_dir="$HOME""/bin"
current_date=`date "+%y%m%d_%H%M%S"`

CTAGS_PROGRAM=`which ctags`
CSCOPE_PROGRAM=`which cscope`

if [ -z "$CTAGS_PROGRAM" -a -z "$CSCOPE_PROGRAM" ]; then
	sudo apt install -y ctags cscope
	if [ "$?" -ne "0" ]; then
		echo "ctags install fail"
		exit 1
	else
		echo "ctags is not exist, install ok"
	fi
fi

CTAGS_PROGRAM=`which ctags`
CSCOPE_PROGRAM=`which cscope`

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	mkdir "${binary_dir}"
fi

if [ ! -f ${binary_dir}"/"${binary_name} ]; then
	echo "${binary_name} is not exist"
fi

if [ -f ${HOME}/.vimrc ]; then
	echo "backup vimrc file"
	if [ ! -d ${HOME}/backup ]; then
		mkdir ${HOME}/backup
	fi	
	cp ${HOME}/.vimrc ${HOME}/backup/.vimrc.${current_date}
fi


# download vim plugin
if [ ! -d ~/.vim/autoload ]; then
	echo "autoload not exist, create it"
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	check_exit_code "install pathogen fail"
fi

if [ ! -d ~/.vim/bundle/supertab ]; then
	echo "supertab not exist, create it"
	git clone https://github.com/ervandew/supertab ~/.vim/bundle/supertab
	check_exit_code "install supertab fail"
fi

if [ ! -d ~/.vim/bundle/nerdtree ]; then
	echo "nerdtree not exist, create it"
	git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
	check_exit_code "install nerdtree fail"
fi

if [ ! -d ~/.vim/pack/airblade/start ]; then
	mkdir -p ~/.vim/pack/airblade/start
	pushd ~/.vim/pack/airblade/start
	git clone https://github.com/airblade/vim-gitgutter.git
	vim -u NONE -c "helptags vim-gitgutter/doc" -c q
	popd
fi

cp ${binary_name} ${binary_dir}"/"${binary_name}
chmod 0777 ${binary_dir}"/"${binary_name}
cp ${binary_name_1} ${binary_dir}"/"${binary_name_1}
chmod 0777 ${binary_dir}"/"${binary_name_1}
cp ${binary_name_2} ${binary_dir}"/"${binary_name_2}
chmod 0777 ${binary_dir}"/"${binary_name_2}

if [ -f ~/bin/ctags ]; then
	sed -e 's/CSCOPE_PROGRAM_WHICH/~\/bin\/cscope/g' \
		-e 's/CTAGS_PROGRAM_WHICH/~\/bin\/ctags/g' .vimrc > ~/.vimrc
else 
	sed -e 's/CSCOPE_PROGRAM_WHICH/\/usr\/bin\/cscope/g' \
		-e 's/CTAGS_PROGRAM_WHICH/\/usr\/bin\/ctags/g' .vimrc > ~/.vimrc
fi

# Add execute environment var
env_status=`cat ~/.bashrc | grep "ORIG_PATH"`

if [ -z "${env_status}" ];then
	echo "env is not set, create it"
	echo "if [ -z \${ORIG_PATH} ]; then" >> ~/.bashrc
	echo "        #echo \"ORIG_PATH is not define, redfine it.\"" >> ~/.bashrc
	echo "        export ORIG_PATH=\${PATH}" >> ~/.bashrc
	echo "fi" >> ~/.bashrc
	echo "export PATH=~/bin:\${ORIG_PATH}" >> ~/.bashrc
fi

echo "sucessfully"
