title: hexo的about界面中多说的新浪微博怎么回事
date: 2016-11-14 13:51:58
tags: [Hexo,多说]
category: Hexo
---

#### 描述

最近遇到个问题，博客的关于(about)界面会出现新浪微博评论，而这些并不是我的博客的评论。后来发现有人也遇到这个[问题](https://www.zhihu.com/question/33262302)，现解决如下。

#### 解决

其实这个问题只要看下界面的源码就能发现，问题在`data-thread-key`的值，我们发现about界面这个值是`about/index.html`，可想而知这个值其他网站也可以用。

然后可以搜索主题下面的代码，发下这个值是在`layout\_partials\comments.swig`路径（请自行搜索关键字）下进行设置，可以看下代码：

```
data-thread-key="{{ page.path }}"
```
于是可以通过判断`page.path`的值来对about界面进行特殊处理，修改代码如下：

```
{% if page.path == 'about/index.html' %}
{% set data_thread_key = 'befuncool/about/index.html' %}
{% endif %}
...
data-thread-key="{{ data_thread_key || page.path }}"
...
```