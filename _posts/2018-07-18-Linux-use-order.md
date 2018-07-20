---
layout:     post
title:        Linux基础命令
subtitle:    Linux基础
date:       2018-07-18
author:     CDX
header-img: img/post-bg-re-vs-ng2.jpg
catalog: true
tags:
    - Aichen
---
## 1、find命令的使用
```
find . -name "*.pyc"  | xargs rm -f      递归删除当前目录中的pyc文件
find -type f -name '*.*' | xargs grep 'str'      查找所有包含str字符串的文件
```
## 2、查看cpu和内存命令
```
top     查看cpu、mem负载、load-average、以及占用内存或cpu占用最多的进程。
sudo yum install sysstat     安装性能监控工具，获得sar命令
sar      sar查看文件读写情况，串口、cpu效率、内存使用情况、进程活动、IPC等
sar -r    查看内存使用情况
sar -W  查看内存页面交换发生情况
sar -n DEV    查看带宽信息
```
## 3、网络监控工具 
```
netstat    显示网络相关信息，
Active Internet connections，称为源TCP连接，其中”Recv-Q”和”Send-Q”指接收队列和发送队列。这些数字一般都应该是0。如果不是则表示软件包正在队列中堆积
Active UNIX domain sockets，称为有源Unix域套接口(跟网络套接字一样，但是只能用于本机通信，性能可以提高一倍)。Proto显示连接使用的协议,RefCnt表示连接到本套接口上的进程号,Types显示套接口的类型,State显示套接口当前的状态,Path表示连接到套接口的其它进程使用的路径名。
netstat 常用参数如下：
a (all)显示所有选项，默认不显示LISTEN相关
t (tcp)仅显示tcp相关选项
u (udp)仅显示udp相关选项
n 拒绝显示别名，能显示数字的全部转化成数字。
l  仅列出有在 Listen (监听) 的服务状态
iptraf    tcp/udp网络监控工具
```
## 4、ssh常用命令
开启电源 --> BIOS开机自检 --> 引导程序lilo或grub--> 内核的引导（kernel boot）--> 执行init（rc.sysinit、rc）--> mingetty(建立终端) -->Shell
```
yum install openssh-server -y      安装ssh-server
ssh-keygen     生成公钥私钥
ssh username@host     连接其他主机
scp copyfile username@host:/filedir/      复制文件到其他主机
```
## 5、权限控制
```
chmod 777 filepath
chgrp username filepath
chown username filepath
-rw------- (600) -- 只有属主有读写权限。
-rw-r--r-- (644) -- 只有属主有读写权限；而属组用户和其他用户只有读权限。
-rwx------ (700) -- 只有属主有读、写、执行权限。
-rwxr-xr-x (755) -- 属主有读、写、执行权限；而属组用户和其他用户只有读、执行权限。
-rwx--x--x (711) -- 属主有读、写、执行权限；而属组用户和其他用户只有执行权限。
-rw-rw-rw- (666) -- 所有用户都有文件读、写权限。这种做法不可取。
-rwxrwxrwx (777) -- 所有用户都有读、写、执行权限。更不可取的做法。
```
## 先写到这