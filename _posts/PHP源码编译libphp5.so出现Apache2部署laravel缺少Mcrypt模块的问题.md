title: PHP源码编译libphp5.so出现Apache2部署laravel缺少Mcrypt模块的问题
date: 2015-04-19 20:02:00
categories: 娱乐
tags: [PHP源码编译, apache, 扩展, mcrypt, --with-apxs2]
description:
---
出现此问题是因为编译libphp5.so时不指定要加入的扩展模块，比如需要某个扩展模块比如mcrypt，解决方法如下：
1./configure --with-apxs2=/usr/local/apache2/bin/apxs --with-mcrypt(--with-mcrypt表示编译的时候要加入mcrypt扩展模块）
   make clean
   make && make install
2apachectl restart (重启apache）
