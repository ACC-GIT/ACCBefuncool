title: Hexo-NexT主题使用mathjax输入数学公式注意事项
date: 2016-11-20 11:28:25
tags: [Hexo,NextT,mathjax]
categories: Hexo
---

<img src="/images/mj-logo.svg" class="full-image" />

Mathjax号称`Beautiful math in all browsers`，是展示数学公式方面的好工具。

下面记录一些在NexT上用mathjax的知识。

#### Mathjax如何使用？

* [Mathjax官方文档](http://docs.mathjax.org/en/latest/start.html)，这里似乎没有太多例子。
* [Mathjax讨论](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)，这个里面例子挺多，够用了。

#### NexT如何集成mathjax？

可以在主题的`_config.xml`下做类似如下配置后便可用：
```
# MathJax Support
mathjax:
  enable: true
  per_page: false
  cdn: //cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML
```

#### 如果框架不提供配置怎么集成mathjax?

也很简单，只要在需要集成的页面上加载一个script即可：
```
<script type="text/javascript"
   src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
```

#### 如何复制别人的mathjax代码？

* 可以查看网页源码，里面有的。
* 可以直接在公式上右键，按照如下图的操作后便可看到代码。
![](/images/mathjax.jpg)
* 有一个在线识别手写数学公式的[工具](https://webdemo.myscript.com/views/math.html)。

#### 注意事项

* 在markdown中使用mathjax下标`_`时，记得一定要写成`\_`，否则将会出现不能解析的情况。