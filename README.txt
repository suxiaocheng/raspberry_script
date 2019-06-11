
[.bashrc]
# Remember to add the following to the bashrc, this could avoid 
# multi define PATH var

if [ -z ${ORIG_PATH} ]; then
        #echo "ORIG_PATH is not define, redfine it."
        export ORIG_PATH=${PATH}
fi
export PATH=~/bin:$ORIG_PATH


[.vimrc]
1. Install pathogen plugin to easy use vim plugin

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

or use github to download the software
git clone https://github.com/tpope/vim-pathogen


2. Add the follow instruction to the .vimrc

execute pathogen#infect()
syntax on
filetype plugin indent on

3. Install the expand plugin

cd ~/.vim/bundle && \
git clone https://github.com/ervandew/supertab


4. Install NERDTree and config .vimrc

git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

map <silent> <F9> /<C-R>=expand("<cword>")<CR><CR>
map <F10> :NERDTreeToggle<CR>
map <F11> :vertical resize -10<CR>
map <F12> :vertical resize +10<CR>

" Nerdtree config
let g:NERDTreeWinPos='right'
let g:NERDChristmasTree=1



5. taglist should insert follow shortcut key
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd="/usr/bin/ctags"



