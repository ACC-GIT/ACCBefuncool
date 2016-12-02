title: Swift如何调用Object-C类
date: 2015-11-26 21:41:00
categories: 娱乐
tags: [Swift, Object-C, Bridging-Header, import, 调用]
description:
---
说明：Xcode提供一个桥接机制，有个-Bridging-Header.h文件，可以在这里设置：targets->build settings ->Object-C Bridging Header。
做法：直接将需要的Object-C类头文件在那个文件里import即可。