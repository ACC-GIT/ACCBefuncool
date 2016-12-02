title: 如何将CSDN的文章转成.md的markdown文件
date: 2016-06-01 17:15:12
tags: 博客迁移
categories: 实用工具
---

以前在CSDN上的文章，现在自己建了个博客，想把原来的文章搬到自己的博客，怎么办呢？

比如我用的是能够解读`.md`文件的博客，那怎么一键将原来自己CSDN上的博文都转换成`.md`文件呢？

答案是有的，按照如下步骤：

### GIT

可以安装个[`TortoiseGit`](https://tortoisegit.org/)

### 下载工具项目

[工具项目](https://github.com/OTHER-ACC/html2markdown4blog)，可以用桌面工具右键clone代码(当然前提是你有Github帐号，如果没有也可以[点这](https://github.com/OTHER-ACC/html2markdown4blog/archive/master.zip)下载）
<img src="/images/git-clone.png" class="full-image" />

### 配置`setting.php`文件
```
'blog_base_url' => 'http://blog.csdn.net
'archive_url' => 'http://blog.csdn.net/AfirSraftGarrier'
'front-matter' => 'Hexo'
```
注意`archive_url`要换成你自己的博客url主页，`fron-matter`是你要转换成的博客类型。

### 运行
注意这里前提是你弄好了php环境，然后在项目根目录运行
```
php start.php
```
### 问题解决
有可能转换失败，原因是目录找不到，可以在根目录下创建`posts`文件夹，到时候生成的文章都在这里面。