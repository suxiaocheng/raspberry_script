
[.bashrc]
if need to update ps1, please add the following line to the bashrc

PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}[\t] \[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


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



