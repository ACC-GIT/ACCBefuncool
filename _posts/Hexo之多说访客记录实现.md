title: Hexo之多说访客记录实现
date: 2015-12-29 16:20:28
tags: [多说, Hexo]
category: Hexo
description:
---

### 访客记录（最近访客）实现方法：

在你想要加入访客记录的页面加上如下代码

```html
<div class="ds-recent-visitors" data-num-items="28"
     data-avatar-size="42" id="ds-recent-visitors"/>
```

我想各参数意思各位可以猜得到就不说了，然后接着在多说后台添加设置：

```css
#ds-recent-visitors .ds-avatar {float:left}
```

然后在多说后台里寻找`#ds-reset .ds-avatar img`这一项，在它后面紧跟添加上`, #ds-recent-visitors .ds-avatar img`(注意有`,`分隔)，意思是两者样式一样。

一般Hexo都集成了多说，所以相关JS代码应该有了，不用再加。

### 官方参考

[多说最近访客官方参考](http://dev.duoshuo.com/docs/4ff28d6f552860f21f00000c)

### 本站参考

> * 关于本站CSS样式设置即设置方法请参考这里：

[本站多说评论的CSS设置](/2015/12/28/本站多说评论的CSS设置/)

<!--more-->

> * 关于本站的最近访客实际效果请看：

[本站最近访客实际效果](/about/)