--- 
layout:     post
title:      Java基础复习
subtitle:   Java 复习
date:       2018-08-06
author:     cdx
header-img: img/post-bg-ios9-web.jpg
catalog: true
tags:
    - Java
---

## strictfp 浮点运算关键字

定义方法类型前加入该关键字可进行强制浮点运算．

## Java位运算

对于java的位运算[参考链接](https://blog.csdn.net/xiaochunyong/article/details/7748713)

## 泛型数组列表

Java SE7中定义泛型列表:

```
ArrayList<Employee> staff = new Arraylist<>();
```

## Java中对于class的理解

class是java编译过后生成的二进制文件，有其自己的标准结构，Class 文件的结构固定了我们编写的class类的存放规则。

经过上述内容的铺垫，0xCAFEBABE是什么意思，应该无需多言了。而<init>是构造方法的意思。再加上(Ljava/lang/reflect/InvocationHandler;)V以及ACC_PUBLIC就可以表示为InvocationHandler的public的构造方法，其中V表示无返回值。

```youtrack
 <init>：对象构造器方法。    
 <clinit>：类构造器方法。
```


