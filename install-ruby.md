
CentOS上にrbenvでRubyをインストール
==============

■ 0. gitインストール
管理者が行う。すでに各ツールがインストールされているなら不要。

sudo yum install git
sudo yum install openssl
sudo yum install openssl-devel
sudo yum install readline

■ 1. rbenvインストール
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv


bashを使っているなら
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

■ 2. ruby-buildインストール

rbenvにruby-buildをインストール
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

■ 3. rubyインストール
rbenv install -l
rbenv install 2.0.0-p0
rbenv versions
rbenv global 2.0.0-p0
rbenv rehash

■ 4. ライブラリーのインストール
gem install bundler
gem update
gem install hike
gem install parallel

■ 5. sqlite3インストール
管理者権限での作業。すでにインストール済みの場合は不要。

sudo yum install sqlite
sudo yum install sqlite-devel

■ 6. rubyのsqliteライブラリのインストール
gem install sqlite3
