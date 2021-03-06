---
layout:     post
title:      Opennebula
subtitle:   Opennebula部署安装与维护心得
date:       2018-07-27
author:     CDX
header-img: img/post-bg-debug.png
catalog: true
tags:
    - 效率
    - OpenNebula
    - zsh
---
 
> 学而不思则罔，思而不学则殆 

## 第一次部署成功
  
记得第一次安装是在17年寒假完成的，那时对于云计算没有太大的感触，或许可以说完全没有概念，安装的过程中出现了很多的问题，当时对于Linux系统不熟悉，甚至还没有自己安装过数据库，硬着头皮上。  

第一次部署成功使用的是SQLite数据库，比较简单，后来为了保证并发和稳定，改换MySQL，在安装数据库的过程中同样学习到了许多。
  
安装过程耗费了大概有几天吧，后来就开始摸索如何使用，不得不说摸索如何使用的过程一点也不比安装部署简单，对于这样的开源项目来讲，使用和维护是更加困难的过程。

## 第一台虚拟机(Centos)
  
安装部署成功之后，就急切的希望可以实现自己的初衷，创建第一台虚拟机，当时对于云的使用还停留在kvm、vm阶段，像OpenNebula这样的私有云是没有接触过的。  
  
按照官方教程的指导，我们没有找到有效的途径，应该是我们的前进方向和阅读能力的问题。

而后在博客中找到了三篇教程，第一篇是如何创建磁盘，第二篇是如何上传镜像，第三篇是如何制作模板。这三篇博客是同一个人写的，但是当时的排版确实是比较乱，只能根据这三篇仅有的指导来不停地尝试，第一次看到安装界面，当时激动了半天，但是你知道的，有的人喜怒不行于色，比如我，强忍着欣喜和激动，静静的等待安装界面的完成。
  
安装后的centos欢迎界面格外的好看，但是有一个致命问题---没有网络。

## 第一个网桥
  
当时有两种方案作为参考，一个是使用网桥方式将虚拟机直接接入网络，第二种是搭建OpenSwitch服务器，由于第二种方案心里没有底气，搭建一个OpenSwitch鬼知道要踩多少坑，花多少时间。  
  
本着快速并偷懒的心里，果断选择网桥，在禁掉Centos网卡的那一刻总觉得会有意外发生，果然不出所料，网络启动失败。还原网络配置文件，重启成功，继续改，重启失败，还原，成功，不停一天的时间。
  
到了第二天，早上来到办公室定了定神，发现了一篇简书上边的关于网桥的文章，一向觉得简书是挺靠谱的，所以果断拿到机房去试，配置文件改掉，怀着忐忑的心情重启网络服务，一次成功。
  
至此，虚拟机终于可以正常运行。

## 第一个启动脚本

OpenNebula的sunstone服务中已经提供了一些OS的镜像，对于使用者来说可以方便的下载，但是当时有一个问题就是我们并不知道网络映像的root密码，导致映像下载之后根本无法登入。

继续Google，在其官方论坛里面发现了一种方法，就是添加开机启动脚本，自动修改root密码，从网上copy了代码，输入到模板的启动脚本框里面，实例化虚拟机，发现虚拟机根本无法boot，一直在等待，不知道是哪里的问题，工作陷入停滞。

问题嘛，总是会解决的，不知道第几次尝试的时候，我突发奇想的去掉了启动脚本的base 64加密，这个看似差不多的模板就创建成功了，毫无防备的把问题给解决掉了。

## 第一台Windows虚拟机

在完成了一点点成就的时候，容易飘，非常容易飘，觉得Linux都成功了，window应该不难，结果被打脸，狠狠的打脸，Window虚拟机的部署耗费了老长时间也没有真正的完成，首先创建就耗费了比较长时间，当时我是拿Windows7做测试的，好不容易安装好之后有没有网卡驱动等等。反正相对于Linux系统的部署是复杂了许多。
  
发现自己真的是Too Young，TooSimple。

## 第一次数据库崩溃

数据库出现问题，对于我来说实在是比较棘手的，当时对于MySql的基本操作算是刚刚上道，系统不停的向数据库写入数据，导致服务无法重新启动，Sunstone也一直处于崩溃状态，当时查资料、看文档，前前后后弄了有三天，但是感觉非常沮丧，眼看着数据不停的重复写入，却无发找到写入流的位置，这就是开源项目使用起来的痛楚。这时，老师拍板，明天（周六）如果解决不掉，所有机器重装。周六就更加仔细、认真的排查问题，因为重装的成本是非常高的。从论坛和博客看了很多的相关知识，但没有现成的解决方法，不停的尝试，终于在磁盘检查之后，删掉数据库的错误日志数据，修复好了系统，系统中与能拿够正常运行。

## 上云迁移

上云迁移的任务好像和云平台部署一样，是一个全新的概念，但是对于我来说，当然还是上网搜索解决方案，自己也做了Excel信息采集表格，对于上云迁移做出了很好的规划，但是现实总是残酷的，我的计划根本没有起到太大的作用。生产环境下的云计算平台的部署就耗费了很多的时间和精力，部署过程中根本无法考虑到上云迁移的任务。部署过程中，任务快速落地、乱序执行，从中学习到了很多关于PaaS的有关问题和解决方法。

## 第一次生产环境部署

生产环境中部署环境是很考验基本功的，很多的小问题当时找不到解决方法，但是后来仔细的想一想，还是自己的基本功不扎实，遇到问题就乱，导致在很小的问题上花费很多时间。其次对于生产环境中的各种基础设施一定要很好的了解，比如说网络方面。硬件设施上也要注意，存储和交换机、防火墙的使用等等。对于商用环境下的网络规划问题也要详细的考虑，绝不能说是能用就行，必须考虑到充分利用基础设施，保证最高的服务质量。

## 第二次生产环境部署

第二次部署之前，练习了很久，用自己的虚拟机搭建环境，熟能生巧还是很有道理的．充分的练习之后，第二次就顺畅了许多几乎两个小时就搞定了一套产品．包括各种配置信息，各种依赖环境等等．所有我觉得能力提高的方法就是多练习，多经历，这样不仅可以提高解决问题的能力，也能锻炼一个人的性格，遇事不乱，遇事不慌．

## 第一次上云迁移

生产环境中的客户需求总是能够出人意料，前期对于虚拟机环境的部署侧重于Linux环境，但是客户的服务全部部署在Windows Server系统，所以需要Server虚拟机的部署快速熟悉，几乎在一天之内，部署了十几台虚拟机．当然这是在开发环境中的测试，不同属性对于虚拟机的影响等等．然后到了生产环境中，还给客户添加部署了ftp服务器，使客户的文件传输更加方便．

## 第一次接触存储

第一次使用存储是使用的杭州宏衫公司的存储硬件，当初第一次部署的时候出现了问题，物理机无法开机自动挂载，一旦修改/etc/fstab 就会导致系统启动时检测磁盘失败，无法启动．当时搞到了晚上十二点多，总算是可以使用．使用的过程中也出现了挺多的问题，分区是公司技术人员已经完成的，然后也给了我们使用和维护文档．真正使用的时候对于存储的挂载的原理不是特别清楚，导致原本已经上传的文件丢失，后来在网上学习到了一种中间文件的方法又把文件重新找了回来．生产环境中使用的时候就具有了一定的经验，但是存储的分区需要我们自己完成，这可牵扯了很多的方面，首先需要规划存储的分区，网络结构，使用权限各个方面．操作完全靠自己，使用和维护也是自己摸索，这是在课堂上接触不到的．

## 第一个生产环境的网络问题
  
当时出现了一个很令人费解的问题，三台主机分别为master、node1、node2，当时的问题是三台主机都可以和网关通信，另外maser可以和node2相互通信、node1和node2可以相互通信、但是master和node1根本ping不通。当时以为是交换机上面被其他的厂商设置了访问协议，后来打电话询问也没有得到有效的解决方法，只是在说没有任何的访问控制。这个问题排查了很长的时间，耗费了很多的精力，最后得到厂家的支持，重启了整个机房网络环境，问题才得以解决。

## 第一次培训
  
对于客户来讲需要一个简单易用的平台才是最重要的，我们为用户提供了说明文档，附带操作视频，而且到现场为用户演示平台的使用，对于用户的需求进行记录、处理。其中用户的需求不断的提升，不断的具体化，也让我们发现了平台中许多的可以改进的地方。

## 第一次资源映射

客户的需求总是能出人意料之外，客户需要虚拟机能够识别产品密钥。密钥我们也具有一定的了解，我们所部署的平台之上也有我们自己制作的产品密钥，但是需要虚拟机识别产品密钥我们没有具体的经验，我们计划一个星期来解决一下这个具体需求，首先方法上定义了一个大方向，利用spice的资源映射， 使虚拟机可以读取到物理机上的资源文件。但是关于spice的文档真的很少，usb-redirect的操作我们用了两天实现，开始的时候是自己摸索，但是突然想起安装部署的过程中使用到了关于重定向功能的rpm安装包，所以猜测系统中或许已经集成了类似的功能，所以大体按照官方的文档来走，从github上找到了一篇比较好的文章，但是并没有具体用法，通过与Spice官网资料的结合，摸索着尝试修改conf文件里面对于资源钩子的定义，终于在将近晚上十一点的时候虚拟机识别usb成功。

## 第一次生产环境密钥映射



![view](http://http://blog.chinaunix.net/attachment/201302/7/20940095_1360212621wRw5.jpg)
