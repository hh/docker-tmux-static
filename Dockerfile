#from ubuntu:10.04
from centos:centos5

maintainer Nate Jones <nate@endot.org>

# something in security seems broken
#Err http://archive.ubuntu.com raring-security/universe amd64 Packages
#  404  Not Found [IP: 91.189.88.149 80]

#run sed -i 's/\(deb.*securit\)/##\ \1/'  /etc/apt/sources.list

#run apt-get update

# Don't install 32bit
run echo multilib_policy=best >> /etc/yum.conf
run echo 'exclude="kernel*"' >> /etc/yum.conf
# maybe don't run update? Grab oldest stuff possible?
# updates to centos-release-5-11, maybe just leave at defaults
# run yum update -y
run yum groupinstall -y "Development Tools"
run yum install -y ncurses-devel curl wget

# run DEBIAN_FRONTEND=noninteractive apt-get install ncurses-dev build-essential wget -y
# run DEBIAN_FRONTEND=noninteractive apt-get install curl -y
#run
# error: 'EVBUFFER_EOL_LF' undeclared
# libevent-dev
run mkdir /tmux

add build.sh /tmux/build.sh
run bash -c "cd /tmux; chmod +x build.sh; ./build.sh"
