---
date: '2016-12-07 20:42 +0800'
published: false
title: how-export-hexo-category
category:
  - Hexo
tags:
  - Hexo
titile: 如何将Hexo的标签和分类导出到自定义格式
---
{% cq %} 要能够根据框架代码生成自定义界面。 {% endcq %}

## 这个功能什么时候要？

比如，你用一些自定义文本编辑器，可以自定义你的标签、分类信息，这时候需要你提供数据，并按照一定格式给出。

## 怎么实现？

这个功能只需要修改一下相应主题的框架代码即可，临时修改一下代码，将想要的形式展现出来，然后拷贝到自定义设置界面即可。这个代码可以在`page.swig`里面找到，比如下面修改就能将所有标签按想要的格式展现出来。

```nodejs
{% for tag in site.tags %}
    - name: "{{ tag.name }}"
     value: "{{ tag.name }}"
{% endfor %}
```

## 注意什么？

Hexo在生成HTML代码的时候，会多出一些空白行，可以全局搜索` \n`(注意这里前面有空格键)，将那些空白行去掉即可。