title: NDK的Helloworld例子
date: 2014-08-24 21:52:00
categories: 娱乐
tags: 
description:
---
**一  环境准备**
1 下载NDK开发包
最好用最新的，如目前为[android-ndk-r10](http://dl.google.com/android/ndk/android-ndk64-r10-windows-x86_64.zip)
2  配置NDK location
位置为解压后的android-ndk-r10目录
![](http://img.blog.csdn.net/20140824222646701?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
**二 例子程序**
1  新建android普通程序。
2  工程名右键-->Android Tools-->Add Native Support，输入库名。
3  在主activity中声明引用的库，声明要调用的库函数。
![](http://img.blog.csdn.net/20140824222833234?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
4  实现应用的函数，注意函数的名称格式Java_开始，中间是包名那些，最后是函数的名字。
![](http://img.blog.csdn.net/20140824222855121?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
5  run
**三 示例程序**
1  [https://github.com/AfirSraftGarrier/NDKHelloworld](https://github.com/AfirSraftGarrier/NDKHelloworld)
