title: Win7远程连接凭据不工作的诡异问题解决
date: 2015-06-23 19:11:00
categories: 娱乐
tags: [Win7, 远程连接, 凭据不工作, 本地用户和组, 登陆]
description:
---
问题：设置了Win7可远程连接，但是输入了本机登陆的用户名、密码，可怎么登都登不上，返回信息：您的凭据不工作。
解决：原来是远程登陆用户名和本机登陆用户名是不一样的，这个在这里可以修改：计算机-->管理-->本地用户和组-->用户。左边名称是远程登陆用户名，右边的全名是本机登陆用户名。
附图：
![](http://img.blog.csdn.net/20150623193737240?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

提醒：如果修改了远程登陆用户名，则本机登陆也会受到影响，不能再用原来的本机登陆用户名，可以用远程登陆用户名。
