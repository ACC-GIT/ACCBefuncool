title: ibatis简述
date: 2016-11-24 18:01:33
tags: ibatis
category: Java框架
---

# 简述

`iBATIS`在2010年被Google改名为`MyBatis`，是一个基于SQL映射的持久层框架。

`iBATIS`属于半自动化`ORM`(Object Relation Mapping)，相比全自动化`ORM`如`Hibernate`，数据库和`POJO`(Plain Ordinary Java Object)之间多了层配置层(xml)。其结构如下图：

<img src="/images/ibatis-map.jpg" class="full-image" />

# 什么时候用`iBATIS`而不用`Hibernate`？

* 当要求不公开表结构给开发人员时。
* 需要对SQL语句优化时。
* 需要映射一些第三方数据库，或是遗留下来的数据库，或是一个设计很差的数据库，这时。

