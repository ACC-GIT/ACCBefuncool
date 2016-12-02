title: Hexo怎么制作和发布百度和谷歌的网站地图
date: 2015-12-29 12:41:55
tags: [网站地图, 百度, 谷歌]
category: Hexo
description:
---

### 网站地图是什么？

网站地图又叫`站点地图`，简单说我们制作好后就是一个文件，里面放了需要搜索引擎抓取的链接，一般放在跟目录下，供`搜索引擎蜘蛛`访问，这样能够方便搜索引擎蜘蛛抓取页面。

### 为什么要做网站地图？

> * 避免搜索引擎遇到`死链接`而没有往下层爬的情况，提高页面搜录量。
> * 可以提供给用户看，方便浏览网站。
> * 网站地图是指向其他页面的链接，给页面增加导入链接，从而提高页面权重，从而提高页面搜录率。

### Hexo如何制作网站地图？

对于Hexo，可以对baidu和google进行制作网站地图，要装一些插件，代码如下：

> * 安装制作百度和谷歌的网站地图的插件

```
npm install hexo-generator-sitemap --save
npm install hexo-generator-baidu-sitemap --save
```

> * Hexo相关配置：要在博客配置文件中加入如下：

```c
sitemap:
path: sitemap.xml
baidusitemap:
path: baidusitemap.xml
```

### 如何安装网站地图？

> * 对于百度，方法如下：

可以先访问这里：[http://zhanzhang.baidu.com/linksubmit](http://zhanzhang.baidu.com/linksubmit)。

（注意：在这之前还需要验证网站什么的，这里不多说。）

<!--more-->

接着截个图如下：

![百度网站地图](/images/baidu_sitemap.png)

> * 对于谷歌，方法如下：

可以先访问这里：[https://www.google.com/webmasters/tools/home](https://www.google.com/webmasters/tools/home)。

（注意：跟前面百度一样，也是要先验证网站。）

接着截个图如下：

![谷歌网站地图](/images/google_sitemap.png)


### 特别提醒：

> * 提交网站地图前，都是要进行验证的，验证方法有几个，**不提倡**通过`robots.txt`文件验证的，请注意`robots.txt`文件是给搜索引擎表明哪些可以爬哪些不可以的。
> * 为保持验证通过的状态,成功验证后请不要删除相关验证信息。