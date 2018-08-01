---
layout: post
title: JAVA-单例模式
subtitle: 单例模式的几种写法
data: 2018-08-01
author: cdx
header-img: img/post-bg-debug.png
catalog: true
tags:
    - JAVA-
    - 设计模式
---

## 单例模式

单例模式是JAVA中最简单的设计模式之一.这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式．在应用这个模式时，丹利对象的类必须保证只有一个实例存在，许多时候整个系统中只需要拥有一个全局对象，这样有利于我们协调系整体的行为．

> 单例类只能有一个实例。

> 单例类必须自己创建自己的唯一实例。

> 单例类必须给所有其他对象提供这一实例。

```
import java.io.Serializable;
public class elvis implements Serializable{
        public static final elvis INSTANCE = new elvis();
        private elvis(){
         System.err.println("elvis constructor is invoked!");     
 }
}


```

### 懒汉模式
  
懒汉模式  线程不安全
```
public class Singleton {  
    private static Singleton instance;  
    private Singleton (){}  

    public static Singleton getInstance() {  
    if (instance == null) {  
        instance = new Singleton();  
    }  
    return instance;  
    }  
}  
```
懒汉模式 线程安全,这样的写法可以在多线程中很好的工作，而且具备很好的lazy loading，但是，这样的写法效率很低，很多情况下并不需要同步。
```
public class Singleton {  
    private static Singleton instance;  
    private Singleton (){}  
    public static synchronized Singleton getInstance() {  
    if (instance == null) {  
        instance = new Singleton();  
    }  
    return instance;  
    }  
}  
```

### 饿汉
  
这种方式基于classloder机制，在深度分析Java的ClassLoader机制（源码级别）和Java类的加载、链接和初始化两个文章中有关于CLassload而机制的线程安全问题的介绍，避免了多线程的同步问题，不过，instance在类装载时就实例化，虽然导致类装载的原因有很多种，在单例模式中大多数都是调用getInstance方法， 但是也不能确定有其他的方式（或者其他的静态方法）导致类装载，这时候初始化instance显然没有达到lazy loading的效果。
  
```
public class Singleton{
    private static Singleton instance = new Singleton();
    private Singleton(){}
    public static Singleton getInstance(){
        return instance;
    }
}

```
### 饿汉变种
  
表面上看起来差别很大，其实和饿汉差不多，都是在类初始化即实例化instance。

```
public class Singleton{
    private Singleton instance = null;
    static{
        instance = new Singleton();
    }
    private Singleton(){}
    public static Singleton getInstance(){
        return this.instance;
    }
} 

```

### 静态内部类
  
这种方式同样利用了classloder的机制来保证初始化instance时只有一个线程，它跟第三种和第四种方式不同的是（很细微的差别）：第三种和第四种方式是只要Singleton类被装载了，那么instance就会被实例化（没有达到lazy loading效果），而这种方式是Singleton类被装载了，instance不一定被初始化。因为SingletonHolder类没有被主动使用，只有显示通过调用getInstance方法时，才会显示装载SingletonHolder类，从而实例化instance。想象一下，如果实例化instance很消耗资源，我想让他延迟加载，另外一方面，我不希望在Singleton类加载时就实例化，因为我不能确保Singleton类还可能在其他的地方被主动使用从而被加载，那么这个时候实例化instance显然是不合适的。这个时候，这种方式相比第三和第四种方式就显得很合理。  
```
public class Singleton{
    private static class SingletonHolder{
        private static final Singleton INSTANCE = new Singleton();
    }
    private Singleton(){}
    public static final Singleton getInstance(){
        return Singletonholder.INSTANCE;
    }
}
```

### 枚举
  
这种方式是Effective Java作者Josh Bloch 提倡的方式，它不仅能避免多线程同步问题，而且还能防止反序列化重新创建新的对象，可谓是很坚强的壁垒啊，在深度分析Java的枚举类型—-枚举的线程安全性及序列化问题中有详细介绍枚举的线程安全问题和序列化问题，不过，个人认为由于1.5中才加入enum特性，用这种方式写不免让人感觉生疏，在实际工作中，我也很少看见有人这么写过。A
```
public enum Singleton{
    INSTANCE;
    public void whateverMethod(){

    }
}
```  

### 双重校验锁
  
  
```
public class Singleton{
    private volatile static Singleton singleton;
    private Singleton(){}
    public static Singleton getSingleton(){
        if(singleton == null){
            synchronized(Singleton.class){
            if(singleton == null){
                singleton = new Singleton();
            }
            }
        }
    return singleton;
    }
}  
```
有两个问题需要注意：

1.如果单例由不同的类装载器装入，那便有可能存在多个单例类的实例。假定不是远端存取，例如一些servlet容器对每个servlet使用完全不同的类装载器，这样的话如果有两个servlet访问一个单例类，它们就都会有各自的实例。

2.如果Singleton实现了java.io.Serializable接口，那么这个类的实例就可能被序列化和复原。不管怎样，如果你序列化一个单例类的对象，接下来复原多个那个对象，那你就会有多个单例类的实例。单例与序列化的那些事儿

## 反射　　

反射是程序可以访问、检测和修改它本身状态或行为的一种能力。Java中的反射，能够创建灵活的代码，这些代码可在运行时装配，无需在组件之间进行源代码链接。简单的说就是：通过class文件对象，去使用该文件中的成员变量，构造方法，成员方法。每个类都有一个Class对象，每当编写并且编译了一个新类，就会产生一个Class对象【被保存在一个同名的.class文件中】所有的类都是在对其第一次使用的时候，动态加载到JVM中。Class对象仅在需要的时候才被加载，static初始化是在类加载时进行的。一旦某个类的Class对象被载入内存，它就被用来创建这个类的所有对象。Class类与java.lang.reflect类库一起对反射的概念进行了支持，该类包含了Filed,Method，Constructor类，这些类型的对象由JVM在运行时创建，用以表示未知类里对应的成员。这样就可以使用Constructor创建新的对象,使用它get( ), set( )方法读取和修改与Field对象关联的字段，用invoke( )方法调用Method对象关联的方法。另外，还可以调用getFields（）、getMethods( )和getConstructor( )等方法，以返回表示字段、方法、以及构造器的对象的数组。这样匿名对象的类信息就可以在运行的时候被完全确定下来，而在编译时不需要知道任何事情．

## 利用反射破坏单例模式
　　
通过反射机制，通过对于实例的映射，找到源类中的对象和方法，利用接口实现对于类的重写，或者是对于jar包的破解．
　　
授权的客户端可以通过反射来调用私有构造方法，借助于AccessibleObject.setAccessible方法即可做到 。如果需要防范这种攻击，请修改构造函数，使其在被要求创建第二个实例时抛出异常。
  

## 单例模式改进
```
import java.io.Serializable;
 public class elvis implements Serializable{     
     public static final elvis INSTANCE = new elvis();
 
     private elvis(){
         System.err.println("elvis constructor is invoked!");
     
         if(INSTANCE!=null){
             System.err.println("实例已存在，无法初始化！");
             throw new UnsupportedOperationException("实例已存在，无法实例化");       
  
     }
 }
}

```
