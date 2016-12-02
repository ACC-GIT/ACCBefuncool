title: linux下支持laravel和apache的php源码编译
date: 2015-08-05 11:41:00
categories: 娱乐
tags: [linux, laravel, apache, php, 源码编译]
description:
---
### 方法：
> * wget [http://mirrors.sohu.com/php/php-5.6.9.tar.gz](http://mirrors.sohu.com/php/php-5.6.9.tar.gz)
> * 进入解压后的php源码目录，执行./configure --enable-fpm --enable-mbstring --with-apxs2=/usr/local/apache2/bin/apxs --with-mcrypt --with-pdo_mysql --with-openssl
 --disable-fileinfo
> * 执行make && make install

### 说明：
> * --enable-fpm是为了能够通过php-fpm的方式启动php，这样可以比php-cgi方式更好管理FastCGI。（后者容易自动挂掉，特别注意上面那些配置要一次写上，如果单独为了使用php-fpm而只是加上了--enable-fpm来编译一个版本，则有可能会使编译版本不一致产生很多问题）
> * --with-apxs2=/usr/local/apache2/bin/apxs这个是和apache相关的，一定要配置，这样编译产生的libphp5.so才会自动加到apache那边去。
> * --with-mcrypt --with-pdo_mysql --with-openssl这些是laravel必须的
> * --disable-fileinfo要加上，不然编译有可能报错：virtual memory exhausted: Cannot allocate memory
