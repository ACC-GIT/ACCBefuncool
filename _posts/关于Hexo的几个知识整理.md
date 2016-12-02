title: 关于Hexo的几个知识整理
date: 2015-12-07 21:58:14
tags: [Hexo, 知识]
category: Hexo
description:
---
以下是玩Hexo遇到的几个问题和解决方法整理。 

<!--more-->

### 文章如何设置多个标签（category同理）?
``` bash
比如标签有A和B，可以在文章的md文件顶部这样设置 tags: [A, B]
```
### hexo d和hexo deploy相同吗（其他如hexo n等同理）?
``` bash
hexo d是hexo deploy的简写，相同。
```
### 每次hexo d前都要hexo g好麻烦，有简便方法吗?
``` bash
可以合并shell语句成hexo g -d。
```
### Hexo有个阅读更多的简介是怎么出来的?
``` bash
在你想要留作简介的段落下面添加一行<!--more-->就可以。
```
### Hexo每篇文章如何添加阅读次数?
``` bash
用`不蒜子`或者`LeanCloud`都可以，具体方法请查找。
```

### 命令hexo d提交到Github的时候都要进行输入用户名密码，有简便方法吗?
``` bash
执行git config --global credential.helper store
或者修改GIT相关的配置为https://[userName]:[password]@github.com/[username]/project.git
```

### 命令hexo g会把Hexo source不相关文件清除，README.md和LICENSE文件怎么办?
``` bash
对于LICENSE等文件，可以放在Hexo博客的根目录的source文件夹中
对于README.md等md文件，想保持就在根目录的_config.yml中配置如skip_render: README.md。
```