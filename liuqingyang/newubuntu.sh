
function root_install()
{     
    echo "12"
}

function module_install()
{
    sudo apt-get -y install lrzsz vim python gcc g++ subversion curl git openssh-server openssh-client
    sudo apt-get -y install sqlite3
    sudo apt-get -y install autoconf libncurses5-dev
    sudo apt-get -y apt-get install libssl-dev
    sudo apt-get -y nautilus-open-terminal
}

function wine_intstall()
{
    sudo add-apt-repository -y ppa:ubuntu-wine/ppa
    sudo apt-get update
    sudo apt-get -y install wine1.8
}

function tftp_install()
{
    #安装tftp 
    sudo apt-get -y install tftp-hpa tftpd-hpa
    if [ ! -d /opt/tftp ]; then
        sudo mkdir /opt /opt/tftp
        sudo chmod 777 /opt
        sudo chmod 777 /opt/tftp
    fi
    sudo sed -i '/^TFTP_DIRECTORY/{s#.*#TFTP_DIRECTORY="/opt/tftp"#}' /etc/default/tftpd-hpa
    sudo sed -i '/^TFTP_OPTIONS/{s#.*#TFTP_OPTIONS="-l -c -s"#}' /etc/default/tftpd-hpa

    sudo service tftpd-hpa restart
}


function nfs_install()
{
    echo "#安装nfs服务"
    sudo apt-get -y install nfs-kernel-server nfs-common

    echo "#修改/etc/exports"
    str=`grep -v "^#" /etc/exports | grep -v "^$"`
    if [ -z "$str" ]; then
        sudo sed -i '$a /home  *(rw,sync,no_root_squash)' /etc/exports
    fi
    #/home *(rw,sync,no_root_squash)
    sudo /etc/init.d/nfs-kernel-server restart


}


function Qt_install()
{
    echo "#安装qt"
    #安装openGL 3d库
    sudo apt-get -y install mesa-common-dev libglu1-mesa-dev
    wget -c http://download.qt.io/archive/qt/5.6/5.6.1/qt-opensource-linux-x64-5.6.1.run
}

function UbuntuSDK_install()
{
    sudo add-apt-repository ppa:ubuntu-sdk-team/ppa
    sudo apt update && sudo apt install ubuntu-sdk
    sudo apt update && sudo apt dist-upgrade
    #launching 
    #ubuntu-sdk
}

function  KVM_install()
{
    sudo apt-get install qemu-kvm
    kvm-ok
}

function snappy_tool_install()
{
    sudo add-apt-repository ppa:snappy-dev/tools
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get -y install snappy bzr
}

function ubuntu_snappy_run()
{
    KVM_install
    wget -c http://releases.ubuntu.com/15.04/ubuntu-15.04-snappy-amd64-generic.img.xz
    unxz ubuntu-15.04-snappy-amd64-generic.img.xz
    kvm -m 512 -redir :8090::80 -redir :8022::22 ubuntu-15.04-snappy-amd64-generic.img
    #login:ubuntu  password:ubuntu
}


function SVN_server_install()
{
    #安装svn包
    sudo apt-get -y install subversion
    #添加svn管理用户及subversion 组
    sudo adduser svnuser
    sudo addgroup subversion
    sudo addgroup svnuser subversion
    #穿件项目目录
    sudo mkdir -p  /home/svn
    sudo mkdir -p  /home/svn/fitness
    #创建svn文件仓库
     sudo svnadmin create /home/svn/fitness
    #更改文件夹权限
    sudo chown -R root:subversion /home/svn/fitness
    sudo chmod -R g+rws /home/svn/fitness
    #修改/home/svn/fitness/conf/svnserve,conf  
    #将以下代码前的#去掉  
    #anon-access = read      此处设置的是匿名用户得权限，如果想拒绝匿名用户则设置为none 
    #auth-access = write       设置有权限用户得权限  
    #password-db = passwd     指定查找用户名和密码得文件，这样设置即为本目录下得passwd文件  
    #authz-db = authz             制定各用户具体权限得文件，这样设置即为本目录下得authz 
    #修改 /home/svn/fitness/conf/passwd  该文件规定了用户名和密码，增加以下内容: 
    #admin = 123456


}

function imx6_yocto_install()
{
    sudo apt-get -y install gawk wget git-core diffstat unzip texinfo build-essential chrpath libsdl1.2-dev xterm curl

}

function imx6q_package()
{
    #download uboot
    git clone git://git.freescale.com/imx/uboot-imx.git
}

function petalinux_env()
{
   sudo apt-get install gawk 

}



#module_install
#tftp_install
#nfs_install
#Qt_install
#ubuntu_snappy_run
#snappy_tool_install
#SVN_server_install
imx6_yocto_install
