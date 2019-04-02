#!/usr/bin/sh

install_git(){
  if ! [ -x "$(command -v git)" ]; then
      echo "Error: git is not installed." >&2
      echo "now begin to install git..." >&2
      sudo apt-get -y install git
      if [ -x "$(command -v git)" ]; then
          echo "git install success!" >&2
      else
          echo "git install failed" >&2
          exit 1
      fi
  fi
}

install_vim(){
  echo "begin to uninstall vim..." >&2
  sudo apt-get -y remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
  echo "begin to install vim" >&2
  echo "first: should install depended package..." >&2
  sudo apt-get -y install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev
  echo "second: clone vim from github..." >&2
  git clone https://github.com/vim/vim
  cd vim
  git pull && git fetch
  echo "third: begin to Compile and install..."
  ./configure \
  --enable-multibyte \
  --enable-perlinterp=dynamic \
  --enable-rubyinterp=dynamic \
  --with-ruby-command=/usr/local/bin/ruby \
  --enable-pythoninterp=dynamic \
  --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
  --enable-python3interp \
  --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
  --enable-luainterp \
  --with-luajit \
  --enable-cscope \
  --enable-gui=auto \
  --with-features=huge \
  --with-x \
  --enable-fontset \
  --enable-largefile \
  --disable-netbeans \
  --with-compiledby="ouyang" \
  --enable-fail-if-missing
  make && make install
  if [ -x "$(command -v vim)" ]; then
    echo "vim install success" > &2
  else
    echo "vim install failed" > &2
    exit 2
  fi
}

# todo 待完善 其他 zsh/tmux/space-vim等等
cd ~
install_git
sleep 10
install_vim
