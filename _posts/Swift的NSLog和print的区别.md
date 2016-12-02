title: Swift的NSLog和print的区别
date: 2015-12-02 13:39:00
categories: 娱乐
tags: [NSLog, print, 调试模式, Swift, 线程安全]
description:
---
主要区别：
       1 NSLog会记录下时间而print没有。
       2 NSLog是线程安全的而print没有。
       3 print只在调试模式下在控制台输出而NSLog在运行模式也会。
总结说明：
       根据上面的区别可以看出一般用print，因为print比较快，而且只在调试模式下起作用，在不考虑线程安全问题时print是较好选择。
