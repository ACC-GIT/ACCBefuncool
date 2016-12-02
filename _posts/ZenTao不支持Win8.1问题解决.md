title: ZenTao不支持Win8.1问题解决
date: 2014-09-23 11:40:00
categories: 娱乐
tags: 
description:
---
ZenTao不支持Win8.1是因为start.bat进行了一些判断，那些组件好像是本来在系统内置了，只是检测不到而已，可以忽略检测，故可以修改start.bat文件，去掉那些判断。
可以用下面这个文件替代原来的start.bat：[ZenTao支持Win8.1修改文件](http://download.csdn.net/detail/afirsraftgarrier/7961963)
