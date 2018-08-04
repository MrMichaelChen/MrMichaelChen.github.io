date +%F
date=`date +%F`
echo $date
filename=$date-$1.md
echo $filename
echo "请确认文件名称，输入ｙ开始编辑，输入ｎ退出"
read input

if [ -e $filename ]
then
    echo "文件已存在"
    exit
fi

echo "--- 
layout:     post
title:      Title
subtitle:   SubTitle
date:       $date
author:     cdx
header-img: img/post-bg-debug.png
catalog: true
tags:
    - Mac
　　- 终端
---
" >> $filename




if [ $input = "y" ]
then
     vim $filename
fi



