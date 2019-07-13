#!/bin/sh

binary_name="update_ctags.sh"
binary_name_1="clear_ctags.sh"
binary_dir="$HOME""/bin"


CTAGS_PROGRAM=`which ctags`
CSCOPE_PROGRAM=`which cscope`

check_exit_code() {
        if [ "$?" -ne "0" ]; then
                echo "program exit unnormal $1"
                exit 1
        fi
}

if [ -z "$CTAGS_PROGRAM" -a -z "$CSCOPE_PROGRAM" ]; then
	sudo apt install -y ctags cscope
	if [[ "$?" -ne "0" ]]; then
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

if [ -f "${binary_dir}/.vimrc" ]; then
	echo "backup vimrc file"
	cp ${HOME}/.vimrc ${HOME}/.vimrc.bak
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

cp ${binary_name} ${binary_dir}"/"${binary_name}
chmod 0777 ${binary_dir}"/"${binary_name}
cp ${binary_name_1} ${binary_dir}"/"${binary_name_1}
chmod 0777 ${binary_dir}"/"${binary_name_1}

if [ -f ~/bin/ctags ]; then
	sed -e 's/CSCOPE_PROGRAM_WHICH/~\/bin\/cscope/g' \
		-e 's/CTAGS_PROGRAM_WHICH/~\/bin\/ctags/g' .vimrc > ~/.vimrc
else 
	sed -e 's/CSCOPE_PROGRAM_WHICH/\/usr\/bin\/cscope/g' \
		-e 's/CTAGS_PROGRAM_WHICH/\/usr\/bin\/ctags/g' .vimrc > ~/.vimrc
fi

# Add execute environment var
env_status=`cat ~/.bashrc | grep ${binary_dir}`

if [ -z "${env_status}" ];then
	echo "env is not set, create it"
	echo "export PATH=\$PATH:${binary_dir}" >> ~/.bashrc
fi

echo "sucessfully"
