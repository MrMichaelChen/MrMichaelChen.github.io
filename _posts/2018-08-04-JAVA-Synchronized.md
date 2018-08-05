---
layout: post
title: Java 多线程
subtitle: Java　线程安全
date: 2018-08-04
author: cdx
header-img: img/post-bg-ios9-web
catalog: true
tags:
    - cdx
    - JAVA
---

> java中对于线程的理解和总结

## JAVA实现多线程的三种方式

### treaed类  

```
package base;

class ThreadView extends Thread {

    private String name;
    ThreadView(String name){
        this.name = name;
    }

    public void run(){
        for (int i = 0 ; i<500 ; i++){
            System.out.println(name + "run: " + i);

            try{
                sleep((int) Math.random() * 10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
    }
}

class Main {
    public static void main(String[] args){
        ThreadView threadView = new ThreadView("A");
        ThreadView threadView1 = new ThreadView("B");
        ThreadView threadView2 = new ThreadView("C");

        threadView.start();
        threadView1.start();
        threadView2.start();
    }
}

```

### 实现runable接口

```
package base;

class ThreadViewRun implements Runnable{
    private String name;

    public ThreadViewRun(String name){
        this.name = name;
    }

    @Override
    public void run() {
        for (int i=0 ; i<=50; i++){
            System.out.println(name + " `run : " +  i);
            try{
                Thread.sleep((int) Math.random() * 10);
            }catch (InterruptedException e){
                e.printStackTrace();
            }
        }

    }

    public static void main(String[] args){
        new Thread(new ThreadViewRun("C")).start();
        new Thread(new ThreadViewRun("D")).start();
    }
}
```  

### 实现callable接口（使用线程池，不要忘记shutdown！）

```
package base;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class ThreadViewCall implements Callable {

    private String name;
    public ThreadViewCall(String name){
        this.name = name;
    }

    @Override
    public Object call() throws Exception {
        for (int i=0; i <500 ; i++){
            System.out.println(name + " run : " + i);
            Thread.sleep(10);
        }
        return "success";
    }


    public static void main(String[] args) throws ExecutionException, InterruptedException {

        int taskSize = 5;

        ExecutorService pool = Executors.newFixedThreadPool(taskSize);

        String [] str = {"a","b","c","d","e","f"};

        List<Future> list = new ArrayList<Future>();

        for(String charstr:str){
            Callable callable = new ThreadViewCall(charstr);

            Future future = pool.submit(callable);
            list.add(future);
            // 多线程ｆｏｒ循环中不要使用输出函数
            //System.out.println(future.get().toString());
        }

        for(Future f: list){
            System.out.println(f.get().toString());
        }

        // 关闭线程池
        pool.shutdown();
    }


}
```

## 多线程的线程安全
 
１．线程安全性(原子性,可见性)
２．线程活跃性
３．性能

## 原子性

原子性是指操作是不可分的。其表现在于对于共享变量的某些操作，应该是不可分的，必须连续完成。
例如a++，对于共享变量a的操作，实际上会执行三个步骤，
1.读取变量a的值  
2.a的值+1  
3.将值赋予变量a 。
这三个操作中任何一个操作过程中，a的值被人篡改，那么都会出现我们不希望出现的结果。所以我们必须保证这是原子性的。Java中的锁的机制解决了原子性的问题。

## 可见性

可见性是值一个线程对共享变量的修改，对于另一个线程来说是否是可以看到的。

为什么会出现这种问题呢？

我们知道，java线程通信是通过共享内存的方式进行通信的，而我们又知道，为了加快执行的速度，线程一般是不会直接操作内存的，而是操作缓存。

![image][https://img-blog.csdn.net/20170902220622756?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvYTYwNzgyODg1/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center]

实际上，线程操作的是自己的工作内存，而不会直接操作主内存。如果线程对变量的操作没有刷写会主内存的话，仅仅改变了自己的工作内存的变量的副本，那么对于其他线程来说是不可见的。而如果另一个变量没有读取主内存中的新的值，而是使用旧的值的话，同样的也可以列为不可见。

对于jvm来说，主内存是所有线程共享的java堆，而工作内存中的共享变量的副本是从主内存拷贝过去的，是线程私有的局部变量，位于java栈中。

简单来说，只要满足了happens-before关系，那么他们就是可见的。

- 1.程序次序规则：一个线程内，按照代码顺序，书写在前面的操作先行发生于书写在后面的操作；
- 2.锁定规则：一个unLock操作先行发生于后面对同一个锁额lock操作；
- 3.volatile变量规则：对一个变量的写操作先行发生于后面对这个变量的读操作；
- 4.传递规则：如果操作A先行发生于操作B，而操作B又先行发生于操作C，则可以得出操作A先行发生于操作C；
- 5.线程启动规则：Thread对象的start()方法先行发生于此线程的每个一个动作；
- 6.线程中断规则：对线程interrupt()方法的调用先行发生于被中断线程的代码检测到中断事件的发生；
- 7.线程终结规则：线程中所有的操作都先行发生于线程的终止检测，我们可以通过Thread.join()方法结束、Thread.isAlive()的返回值手段检测到线程已经终止执行；
- 8.对象终结规则：一个对象的初始化完成先行发生于他的finalize()方法的开始；

## 有序性

有序性是指程序在执行的时候，程序的代码执行顺序和语句的顺序是一致的。

为什么会出现不一致的情况呢？

这是由于重排序的缘故。

在Java内存模型中，允许编译器和处理器对指令进行重排序，但是重排序过程不会影响到单线程程序的执行，却会影响到多线程并发执行的正确性。

举个例子：

线程A:
```
context = loadContext();    
inited = true;    
```
线程B:
```
while(!inited ){
 sleep
}
doSomethingwithconfig(context);
```

如果线程A发生了重排序：
```
inited = true;    
context = loadContext(); 
```
那么线程B就会拿到一个未初始化的content去配置，从而引起错误。
因为这个重排序对于线程A来说是不会影响线程A的正确性的，而如果loadContext()方法被阻塞了，为了增加Cpu的利用率，这个重排序是可能的。

如果要防止重排序，需要使用`volatile`关键字，volatile关键字可以保证变量的操作是不会被重排序的。

## 锁的状态总共有四种
  
无锁状态、偏向锁、轻量级锁和重量级锁。随着锁的竞争，锁可以从偏向锁升级到轻量级锁，再升级的重量级锁，但是锁的升级是单向的，也就是说只能从低到高升级，不会出现锁的降级，关于重量级锁，前面我们已详细分析过，下面我们将介绍偏向锁和轻量级锁以及JVM的其他优化手段，这里并不打算深入到每个锁的实现和转换过程更多地是阐述Java虚拟机所提供的每个锁的核心优化思想，毕竟涉及到具体过程比较繁琐，如需了解详细过程可以查阅《深入理解Java虚拟机原理》。

偏向锁
偏向锁是Java 6之后加入的新锁，它是一种针对加锁操作的优化手段，经过研究发现，在大多数情况下，锁不仅不存在多线程竞争，而且总是由同一线程多次获得，因此为了减少同一线程获取锁(会涉及到一些CAS操作,耗时)的代价而引入偏向锁。偏向锁的核心思想是，如果一个线程获得了锁，那么锁就进入偏向模式，此时Mark Word 的结构也变为偏向锁结构，当这个线程再次请求锁时，无需再做任何同步操作，即获取锁的过程，这样就省去了大量有关锁申请的操作，从而也就提供程序的性能。所以，对于没有锁竞争的场合，偏向锁有很好的优化效果，毕竟极有可能连续多次是同一个线程申请相同的锁。但是对于锁竞争比较激烈的场合，偏向锁就失效了，因为这样场合极有可能每次申请锁的线程都是不相同的，因此这种场合下不应该使用偏向锁，否则会得不偿失，需要注意的是，偏向锁失败后，并不会立即膨胀为重量级锁，而是先升级为轻量级锁。下面我们接着了解轻量级锁。

轻量级锁
倘若偏向锁失败，虚拟机并不会立即升级为重量级锁，它还会尝试使用一种称为轻量级锁的优化手段(1.6之后加入的)，此时Mark Word 的结构也变为轻量级锁的结构。轻量级锁能够提升程序性能的依据是“对绝大部分的锁，在整个同步周期内都不存在竞争”，注意这是经验数据。需要了解的是，轻量级锁所适应的场景是线程交替执行同步块的场合，如果存在同一时间访问同一锁的场合，就会导致轻量级锁膨胀为重量级锁。

自旋锁
轻量级锁失败后，虚拟机为了避免线程真实地在操作系统层面挂起，还会进行一项称为自旋锁的优化手段。这是基于在大多数情况下，线程持有锁的时间都不会太长，如果直接挂起操作系统层面的线程可能会得不偿失，毕竟操作系统实现线程之间的切换时需要从用户态转换到核心态，这个状态之间的转换需要相对比较长的时间，时间成本相对较高，因此自旋锁会假设在不久将来，当前的线程可以获得锁，因此虚拟机会让当前想要获取锁的线程做几个空循环(这也是称为自旋的原因)，一般不会太久，可能是50个循环或100循环，在经过若干次循环后，如果得到锁，就顺利进入临界区。如果还不能获得锁，那就会将线程在操作系统层面挂起，这就是自旋锁的优化方式，这种方式确实也是可以提升效率的。最后没办法也就只能升级为重量级锁了。

锁消除
消除锁是虚拟机另外一种锁的优化，这种优化更彻底，Java虚拟机在JIT编译时(可以简单理解为当某段代码即将第一次被执行时进行编译，又称即时编译)，通过对运行上下文的扫描，去除不可能存在共享资源竞争的锁，通过这种方式消除没有必要的锁，可以节省毫无意义的请求锁时间，如下StringBuffer的append是一个同步方法，但是在add方法中的StringBuffer属于一个局部变量，并且不会被其他线程所使用，因此StringBuffer不可能存在共享资源竞争的情景，JVM会自动将其锁消除。
