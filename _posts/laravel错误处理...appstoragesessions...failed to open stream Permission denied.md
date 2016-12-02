title: laravel错误处理...app/storage/sessions...failed to open stream->Permission denied
date: 2015-08-05 11:48:00
categories: 娱乐
tags: [laravel, bug, sessions, Permission denied, artisan]
description:
---
方法：到laravel跟目录下执行如下操作：
```bash
1）php artisan cache:clear 
2）chmod -R 777 app/storage
3）php artisan dump-autoload
```