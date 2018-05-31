# install zsh
# install plugins
# install vim
# install docker
# install ---

# 检查是否为root
if [ ${USER}h != rooth ]
then
		echo "you are not root"
		exit 2
fi


cat > /etc/yum.repos.d/CentOS-Base.repo <<EOF
[base]
name=CentOS-\$releasever - Base
#mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=os
baseurl=https://mirrors.ustc.edu.cn/centos/\$releasever/os/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-\$releasever - Updates
# mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=updates
baseurl=https://mirrors.ustc.edu.cn/centos/\$releasever/updates/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-\$releasever - Extras
# mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=extras
baseurl=https://mirrors.ustc.edu.cn/centos/\$releasever/extras/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-\$releasever - Plus
# mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=centosplus
baseurl=https://mirrors.ustc.edu.cn/centos/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF
sudo yum makecache
yum -y update

yum install -y -q zsh vim curl docker axel iftop nload git

yum install -y yum-utils \
           device-mapper-persistent-data \
           lvm2

curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun

sudo groupadd docker
sudo usermod -aG docker $USER
cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn/"]
}
EOF
systemctl start docker
systemctl restart docker
docker pull php
docker pull node
docker pull nginx
docker pull mariadb
docker pull centos
docker pull phpmyadmin/phpmyadmin
docker pull kali-linux-docker


# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd ~ 
cat > .zshrc << EOF
export PATH=\$HOME/bin:/usr/local/bin:\$PATH
export ZSH=~/.oh-my-zsh
ZSH_THEME="random"
COMPLETION_WAITING_DOTS="true"
plugins=(
  git docker zsh-autosuggestions zsh-syntax-highlighting
)
source \$ZSH/oh-my-zsh.sh

export PATH=$PATH:$(go env GOPATH)/bin
EOF

# install zsh-autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

chsh -s /bin/zsh root

yum install -y go
go get -u github.com/jingweno/ccat

# install dry-bin
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dry


zsh



source ~/.zshrc
