#!/bin/bash

if [ ! -d ${HOME}/tmp ]; then
	mkdir ${HOME}/tmp
fi

pushd ${HOME}/tmp

curl https://sh.rustup.rs -sSf | sh
git clone https://github.com/BurntSushi/ripgrep
cd ripgrep
cargo build --release
cp ./target/release/rg ${HOME}/bin/

popd

