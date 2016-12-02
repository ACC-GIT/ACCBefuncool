title: Go之初见
date: 2016-11-22 01:56:05
tags: Go
category: Go
---

<img src="/images/go.png" class="full-image" />

### 前言

Go语言是Google于2009年推出的[开源语言](https://github.com/golang/go)，又叫`Golang`，Go具有如下特性：

* 其并发机制让使用者很容易写出充分利用多核和网络机器的程序来，且不失灵活性。
* 可快速编译成机器码，并且还具有GC和运行时反射的功能。
* 是一种静态语言，同时又具有动态语言的特性。

### 感受

Go的官网在[这里](https://golang.org/)，可以在[这里](https://gobyexample.com/)在网页上感受下Go的风貌(在代码块右上角有个图标，点击可进入网页IDE)。另外可以在[这里](https://tour.golang.org)有个简单的教程，并且还能网页上运行相应代码，非常之便利(同样注意右上角可以进行例子选择)。关于这个网页Go的原理可看下面这张图，简单说就是运用`RPC`,将客户端代码放到服务端取执行，然后返回结果给我们的网页客户端展现。
![](/images/goweboverview.png)

### 安装

这里以Windows环境为例。

* 到[这里](https://golang.org/dl/)下载相应的版本，然后安装，这里选择Windows的`MSI`文件安装(安装程序会自动设置环境变量)。
* 

安装完后，打开一个命令行