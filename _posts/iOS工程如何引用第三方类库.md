title: iOS工程如何引用第三方类库
date: 2015-11-25 23:35:00
categories: 娱乐
tags: [iOS, cocoapods, xcode, taobao, pod]
description:
---
iOS有个对工程进行依赖管理的工具CocoaPods。
注意事项：
1 有可能安装不上cocoapods，是因为官方ruby镜像被墙了。可以换成taobao的ruby镜像如下操作：
```bash
$ gem sources --remove https://rubygems.org/
$ gem sources -a http://ruby.taobao.org/
```
2 pod install安装第三方类库后，需要关闭所有的Xcode，然后打开指定的.xcworkspace文件才生效。