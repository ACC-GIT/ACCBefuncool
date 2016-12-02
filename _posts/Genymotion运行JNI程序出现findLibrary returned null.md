title: Genymotion运行JNI程序出现findLibrary returned null
date: 2014-08-24 20:13:00
categories: 娱乐
tags: 
description:
---
原因：Genymotion虚拟机可能CPU类型为x86，需要编译出x86的库文件。
方法：可以在Application.mk中设置APP_ABI := all。
