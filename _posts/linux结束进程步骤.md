title: linux结束进程步骤
date: 2015-08-05 12:00:00
categories: 娱乐
tags: [linux, 结束进程, aux, pid, kill -9]
description:
---
### 例子：比如要关闭php-fpm
### 方法：
1）ps aux | grep php-fpm得到如下图：
![](http://img.blog.csdn.net/20150805115726269?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
2）上图中的红色数字就是进程的pid，接着执行kill -9 8860 （注意kill -9表示强制结束的意思）。