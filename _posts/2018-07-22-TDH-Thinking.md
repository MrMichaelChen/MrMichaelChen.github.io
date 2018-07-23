---
layout:     post
title:      面试准备
subtitle:   面试准备
date:       2018-07-22
author:     cdx
header-img: img/post-bg-hacker.jpg
catalog: true
tags:
    - Hadoop
---
## 大数据个人认识
1、数据可视化
2、量化分析
3、Hadoop、NoSQL搜索引擎、批量分析组件、流处理组件和数据挖掘组件
## 源数据和数据集
1、数据集录入
2、数据报表
## TDH Inceptor
1、PL/SQL引擎
2、交互分析
3、图计算
## TDH Stream
1、流处理引擎
2、SQL
## 数据挖掘工具Discover
1、集成notebook
2、不同语言编程
3、不同用户同时广播
4、机器学习
## TDH Hyperbase
1、NoSQL数据库综合搜索
## TDH Midas
1、神经网络编程
2、资源库和算子
3、从设计到结果
## 资源管理 YARN
• 用户将应用程序提交到RM 
• RM为AM申请资源，与某个NM通信，启动AM 
• AM与RM通信，为执行任务申请资源 
• 得到资源后与NM通信，启动相应的任务
• 所有任务结束后，AM向RM注销，整个应用结束
## 优化存储HDFS、全文搜索
## MR
• 一个split（切片）起一个map任务 • map输出时会先将输出中间结果写入到buffer中 
• 在buffer中对数据进行partition（分区，partition数为reduce数）和基于key的 sort（排序），达到阈值后spill到本地磁盘 
• 在map任务结束之前，会对输出的多个文件进行merge（合并），合并成一个 文件 • 每个reduce任务会从多个map输出中拷贝自己的partition 
• reduce也会将数据先放到buffer中，达到阈值会写到磁盘 
• 当数据该reduce的map输出全部拷贝完成，合并多个文件成一个文件，并保持 基于key的有序 
• 最后，执行reduce阶段，运行我们实现的reduce中化简逻辑，最终将结果直接 输出到HDFS中