﻿--- 
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

## java设计模式

创建型，结构型，行为型。

单例模式：某个类只能有一个实例，提供一个全局的访问点。

简单工厂：一个工厂类根据传入的参量决定创建出那一种产品类的实例。

工厂方法：定义一个创建对象的接口，让子类决定实例化那个类。

抽象工厂：创建相关或依赖对象的家族，而无需明确指定具体类。

建造者模式：封装一个复杂对象的构建过程，并可以按步骤构造。

原型模式：通过复制现有的实例来创建新的实例。

 

适配器模式：将一个类的方法接口转换成客户希望的另外一个接口。

组合模式：将对象组合成树形结构以表示“”部分-整体“”的层次结构。

装饰模式：动态的给对象添加新的功能。

代理模式：为其他对象提供一个代理以便控制这个对象的访问。

亨元（蝇量）模式：通过共享技术来有效的支持大量细粒度的对象。

外观模式：对外提供一个统一的方法，来访问子系统中的一群接口。

桥接模式：将抽象部分和它的实现部分分离，使它们都可以独立的变化。

 

模板模式：定义一个算法结构，而将一些步骤延迟到子类实现。

解释器模式：给定一个语言，定义它的文法的一种表示，并定义一个解释器。

策略模式：定义一系列算法，把他们封装起来，并且使它们可以相互替换。

状态模式：允许一个对象在其对象内部状态改变时改变它的行为。

观察者模式：对象间的一对多的依赖关系。

备忘录模式：在不破坏封装的前提下，保持对象的内部状态。

中介者模式：用一个中介对象来封装一系列的对象交互。

命令模式：将命令请求封装为一个对象，使得可以用不同的请求来进行参数化。

访问者模式：在不改变数据结构的前提下，增加作用于一组对象元素的新功能。

责任链模式：将请求的发送者和接收者解耦，使的多个对象都有处理这个请求的机会。

迭代器模式：一种遍历访问聚合对象中各个元素的方法，不暴露该对象的内部结构。

## java关键字volatile

java中的synchronizd已经保证了java的并发操作，可以将volatile看作一个轻量型的并发控制。

 

