---
date: '2017-06-18 13:27 +0800'
published: true
title: Alamofire的一个坑
category:
  - IOS
tags:
  - iOS
---
<img src="http://afirsraftgarrier.qiniudn.com/alamofire.png" class="full-image" />

## 前言
    都知道Alamofire是一个比较火的iOS网络请求库，用着比较方便，但里面有个坑爹的地方是，文档里并没有对超时(timeout)问题做更进一步描述。
	Alamofire默认的超时时间是一分钟，要等比较久，如果加上loading效果，这么长时间loading体验不好。解决方法是要修改超时时间。查了些资料，是要进行类似如下设置：
    
```
let configuration = URLSessionConfiguration.default
configuration.timeoutIntervalForRequest = 1000
let sessionManager = Alamofire.SessionManager(configuration: configuration)
```

## 解决
	然后是进行请求`sessionManager.request...`。这样你会发现，怎么按照网上的修改都不起作用。后面去官方`issue`查到，原来，不能在方法里面进行这些设置，`sessionManager`在退出方法后便被回收，设置自然不起作用，正确的方法是要保持一个公有的`sessionManager`变量，这样就不会被回收。即要进行类似如下改动：
    
```
static let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
```
