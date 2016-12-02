title: mysql数据库数据迁移方法
date: 2015-08-04 14:55:00
categories: 娱乐
tags: [mysql, 数据库, 迁移, .idb, innodb_force_recover]
description:
---
说明：这里不讨论命令行还有通过navicat等工具的做法，这里只讨论在mysql坏掉（不能启动）的情况下，怎么办。
方法：
a) 先来看mysql数据库文件的情况：
mysql坏掉了，不管是linux还是windows版本，mysql有个数据库文件目录data目录，如下图：
![](http://img.blog.csdn.net/20150804143020953?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
（注意linux版上面的是my.cnf差不多）
然后data目录里面类似这样：
![](http://img.blog.csdn.net/20150804143149670?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
通过观察可以知道里面一个个文件夹如world这些就是一个个database。进入这个文件就是类似下面两种情况：
情况一：![](http://img.blog.csdn.net/20150804143425201?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)               or               情况二： ![](http://img.blog.csdn.net/20150804143434747?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
可以猜想就是一个个表文件。
b) 再来看下如何迁移这些数据库。
对于上面的情况一，即数据库文件是.frm、.MYD、.MYI的情况，这种情况超级方便，直接将这个database文件夹拷贝到要迁移到的目标数据库目录即可。
对于上面的情况二，即数据库文件是.frm、.idb的情况，则要这样处理：
i) 将database文件夹拷贝到一个可用的mysql数据库目录(以下简称中间数据库)。
ii) 停止中间数据库，备份中间数据库的ibdata1文件，然后替换ibdata1文件。
iii)中间数据库的my.ini末尾添加一行innodb_force_recovery=4。
iv) 启动中间数据库，通过工具或命令行的方式，将中间数据库的目标database迁移到目标数据库。
v) 中间数据库回退处理（即注释掉innodb_force_recovery=4，回退ibdata1文件那些，不影响中间数据库）。
