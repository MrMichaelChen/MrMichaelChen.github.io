---
layout:     post
title:      SQL复习
subtitle:   简单的复习，复杂的挖掘
date:       2018-07-27
author:     CDX
header-img: img/post-bg-ios9-web.jpg
catalog: true
tags:
    - Obj-C
    - Runtime
    - iOS
--- 
  
>学从难处学，用从易处用
  
## SQL基本命令
  
```
show databases;

show tables;

create database totest;

use totest;

create table test(
id smallint,
name varchar(20)
);

desc test;

select * from test;

insert into test values(1,"cdx");

delete from test where id = 1;

select * from test where id = 1 and name like "cdx";

select id as userid,name as username from test where id > 0;

select * from test group by id having id <= 10;

create table testinfo(
    userid smallint;
    key varchar(10);
    keyvalue varchar(20);
); 

insert into testinfo values(1,"heigth","177");

insert into testinfo set user=1,key="weigth","70";

select test.id,testinfo.userid,testinfo.key,testinfo.keyvalue from test as e join testinfo as m on e.id = m.userid where test.id > 1 order by test.id;

select test.id,testinfo.userid,testinfo.key,testinfo.keyvalue from test as e left join testinfo as m on e.id = m.userid where n.name like "%dx" limit 15;

select * from testinfo limit 15;

update testinfo set keyvaluey="69" where userid = 1 and key = "weigth";"

alter table test add column sex varchar (10) after test;

alter table test change column name username;

create table userinfo select * from testinfo where id > 1;
```
  
## 删除重复记录
  
删除重复记录时，需要通过视图进行查找，但是能根据视图直接删除数据，需要另外定义中间数据表进行删除操作。  

```
delete from student where id not in (select minid from (select min(id) as minid from student group by name) b);
```
  
## Mysql full join的实现
  
``MySQL Full Join``的实现
MySQL Full Join的实现 因为MySQL不支持FULL JOIN,下面是替代方法
left join + union(可去除重复数据)+ right join
  
```  
两张表时：
select * from A left join B on A.id = B.id (where 条件）
union
select *from A right join B on A.id = B.id （where条件);
```

## Sql性能优化

1.查询的模糊匹配

尽量避免在一个复杂查询里面使用 LIKE '%parm1%'—— 红色标识位置的百分号会导致相关列的索引无法使用，最好不要用.

解决办法:

其实只需要对该脚本略做改进，查询速度便会提高近百倍。改进方法如下：

a、修改前台程序——把查询条件的供应商名称一栏由原来的文本输入改为下拉列表，用户模糊输入供应商名称时，直接在前台就帮忙定位到具体的供应商，这样在调用后台程序时，这列就可以直接用等于来关联了。

b、直接修改后台——根据输入条件，先查出符合条件的供应商，并把相关记录保存在一个临时表里头，然后再用临时表去做复杂关联

2.索引问题

在做性能跟踪分析过程中，经常发现有不少后台程序的性能问题是因为缺少合适索引造成的，有些表甚至一个索引都没有。这种情况往往都是因为在设计表时，没去定义索引，而开发初期，由于表记录很少，索引创建与否，可能对性能没啥影响，开发人员因此也未多加重视。然一旦程序发布到生产环境，随着时间的推移，表记录越来越多

这时缺少索引，对性能的影响便会越来越大了。

这个问题需要数据库设计人员和开发人员共同关注

法则：不要在建立的索引的数据列上进行下列操作:

◆避免对索引字段进行计算操作

◆避免在索引字段上使用not，<>，!=

◆避免在索引列上使用IS NULL和IS NOT NULL

◆避免在索引列上出现数据类型转换

◆避免在索引字段上使用函数

◆避免建立索引的列中使用空值。

3.复杂操作

部分UPDATE、SELECT 语句 写得很复杂（经常嵌套多级子查询）——可以考虑适当拆成几步，先生成一些临时数据表，再进行关联操作

4.update

同一个表的修改在一个过程里出现好几十次，如：

update table1
set col1=...
where col2=...;
update table1
set col1=...
where col2=...
......
象这类脚本其实可以很简单就整合在一个UPDATE语句来完成（前些时候在协助xxx项目做性能问题分析时就发现存在这种情况）

5.在可以使用UNION ALL的语句里，使用了UNION

UNION 因为会将各查询子集的记录做比较，故比起UNION ALL ，通常速度都会慢上许多。一般来说，如果使用UNION ALL能满足要求的话，务必使用UNION ALL。还有一种情况大家可能会忽略掉，就是虽然要求几个子集的并集需要过滤掉重复记录，但由于脚本的特殊性，不可能存在重复记录，这时便应该使用UNION ALL，如xx模块的某个查询程序就曾经存在这种情况，见，由于语句的特殊性，在这个脚本中几个子集的记录绝对不可能重复，故可以改用UNION ALL）

6.在WHERE 语句中，尽量避免对索引字段进行计算操作

这个常识相信绝大部分开发人员都应该知道，但仍有不少人这么使用，我想其中一个最主要的原因可能是为了编写写简单而损害了性能，那就不可取了

9月份在对XX系统做性能分析时发现，有大量的后台程序存在类似用法，如：

......
where trunc(create_date)=trunc(:date1)
虽然已对create_date 字段建了索引，但由于加了TRUNC，使得索引无法用上。此处正确的写法应该是

where create_date>=trunc(:date1) and create_date
或者是

where create_date between trunc(:date1) and trunc(:date1)+1-1/(24*60*60)
注意：因between 的范围是个闭区间（greater than or equal to low value and less than or equal to high value.），

故严格意义上应该再减去一个趋于0的小数，这里暂且设置成减去1秒（1/(24*60*60)），如果不要求这么精确的话，可以略掉这步。

7.对Where 语句的法则

7.1 避免在WHERE子句中使用in，not  in，or 或者having。

可以使用 exist 和not exist代替 in和not in。

可以使用表链接代替 exist。Having可以用where代替，如果无法代替可以分两步处理。

例子

SELECT *  FROM ORDERS WHERE CUSTOMER_NAME NOT IN 
(SELECT CUSTOMER_NAME FROM CUSTOMER)
优化


SELECT *  FROM ORDERS WHERE CUSTOMER_NAME not exist 
(SELECT CUSTOMER_NAME FROM CUSTOMER)
  
7.2 不要以字符格式声明数字，要以数字格式声明字符值。（日期同样）否则会使索引无效，产生全表扫描。

例子使用：

SELECT emp.ename, emp.job FROM emp WHERE emp.empno = 7369;
不要使用：SELECT emp.ename, emp.job FROM emp WHERE emp.empno = ‘7369’
  
8.对Select语句的法则

在应用程序、包和过程中限制使用select * from table这种方式。看下面例子

使用SELECT empno,ename,category FROM emp WHERE empno = '7369‘
而不要使用SELECT * FROM emp WHERE empno = '7369'
  
9. 排序

避免使用耗费资源的操作，带有DISTINCT,UNION,MINUS,INTERSECT,ORDER BY的SQL语句会启动SQL引擎 执行，耗费资源的排序(SORT)功能. DISTINCT需要一次排序操作, 而其他的至少需要执行两次排序

10.临时表
  
慎重使用临时表可以极大的提高系统性能

### Sql语句的性能优化

一般而言，如果注重性能，首先应该选择使用联接而不是子选择。性能差异取决于您的数据库引擎。
  
## Sql unsigned

Mysql中的1-2得0xFFFFFFFF，只是0xFFFFFFFF可以代表两种值：对于无符号的整型值，其是整型数的最大值，即4 294 967 295;对于有符号的整型数来说，第一位代表符号位，如果是1，表示是负数，这时应该是取反加1得到负数值，即-1。

## 覆盖索引

覆盖索引就是将查找的内容全部放置到索引当中，有效的提高索引效率，对于查找的语句不必从表中读取元数据，可以从索引中取得．索引的建立对于插入操作的效率影响非常小，但是对于查找效率的提升非常明显．

## 唯一索引

唯一索引是这样一种索引，它通过确保表中没有两个数据行具有完全相同的键值来帮助维护数据完整性。

为包含数据的现有表创建唯一索引时，会检查组成索引键的列或表达式中的值是否唯一。如果该表包含具有重复键值的行，那么索引创建过程会失败。为表定义了唯一索引之后，每当在该索引内添加或更改键时就会强制执行唯一性。此强制执行包括插入、更新、装入、导入和设置完整性以命名一些键。除了强制数据值的唯一性以外，唯一索引还可用来提高查询处理期间检索数据的性能。

非唯一索引不用于对与它们关联的表强制执行约束。相反，非唯一索引通过维护频繁使用的数据值的排序顺序，仅仅用于提高查询性能。

## 主键或唯一键约束与唯一索引之间的差别
了解主键约束或唯一键约束与唯一索引之间没有很大差别这一点很重要。为了实现主键约束和唯一键约束的概念，数据库管理器使用唯一索引与 NOT NULL 约束的组合。因此，唯一索引本身不强制执行主键约束，因为它们允许空值。虽然空值表示未知值，但在建立索引时，会将一个空值视为与其他空值相同。

因此，如果唯一索引由单个列组成，那么只允许一个空值 - 多个空值将违反唯一约束。类似地，如果唯一索引由多个列组成，那么值与空值的特定组合只能使用一次。


  

[SQL基本命令](https://www.ibm.com/developerworks/cn/linux/l-lpic1-105-3/index.html)
[SQL优化](http://database.51cto.com/art/200904/118526.htm)
