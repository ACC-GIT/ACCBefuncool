title: JPA使用多个FetchType.EAGER出现错误Caused by->org.hibernate.loader.MultipleBagFetchException->cannot simultan
date: 2015-05-06 11:16:00
categories: 娱乐
tags: [jpa, FetchType.EAGER, FetchMode.SELECT]
description:
---
1  更多内容请参考[这里](http://stackoverflow.com/questions/17566304/multiple-fetches-with-eager-type-in-hibernate-with-jpa)。
2  解决方案：添加注解@Fetch(FetchMode.SELECT)。