---
layout:     post
title:      SQL复习
subtitle:   简单的复习，复杂的挖掘
date:       2018-07-27
author:     BY
header-img: img/post-bg-ios9-web.jpg
catalog: true
tags:
    - Obj-C
    - Runtime
    - iOS
--- 
>学从难处学，用从易处用
  
## SQL基本命令
-
  
## 删除重复记录
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
