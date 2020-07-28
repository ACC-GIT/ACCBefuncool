title: Markdown操作汇总
date: 2016-11-23 16:06:23
tags: 工具
category: 工具
---

<img src="/images/markdown.jpg" class="full-image" />

现在写博客等常用到Markdown，为了方便查找，做个记录。

Markdown是用`perl`写的，将`text`文件按标记转成`html`文件的工具，可以看看其作者的[介绍](http://daringfireball.net/projects/markdown/syntax)。下面来总结下它的用法。

# 1. 标题

标题只有六级，用`#`来表示，这个符号越多表示标题越小。

```
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
```
效果如下：

# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题

# 2. 列表

#### 无序列表

即没顺序的列表(注意列表下面要留一空行，否则会出现下面的标签解析错误情况)。
```
* 列表一
* 列表二
* 列表三
```
效果如下：

* 列表一
* 列表二
* 列表三

<!--more-->

#### 有序列表
即有顺序的列表(注意到这里序号并不重要)。
```
2. 列表一
1. 列表二
5. 列表三
```
效果如下：
2. 列表一
1. 列表二
5. 列表三

#### 二级列表
用`tab`再加个`*`号(注意更高级列表同理)：
```
* 这是一级列表
    * 这是二级列表
```
效果是：
* 这是一级列表
    * 这是二级列表

# 3. 引用
使用`>`表示引用(注意同上面列表也可以做二级)：
```
> 这是引用
```
效果：
> 这是引用

# 4. 行内代码块
使用\`代码块\`表示行内代码块：
```
这是`行内代码块`
```
效果：
这是`行内代码块`

# 5. 代码块

#### 普通代码块

四个缩进空格表示代码块：
```
    前面是四个空格
```
效果是：

    前面是四个空格

#### 加强版代码块

支持多种语言，如`python`代码块，则用\`\`\`python打头，\`\`\`结尾(注意要根据不同语言选择不同头)，如下：

```
```python
@requires_authorization
def somefunc(param1='', param2=0):
    '''A docstring'''
    if param1 > param2: # interesting
        print 'Greater'
    return (param2 - param1 + 1) or None

class SomeClass:
    pass
```.
```

效果如下：

```python
@requires_authorization
def somefunc(param1='', param2=0):
    '''A docstring'''
    if param1 > param2: # interesting
        print 'Greater'
    return (param2 - param1 + 1) or None

class SomeClass:
    pass
```
# 6. 删除线
  
使用 ~~ 表示删除线。如：

```
~~错误文本~~
```
效果是：

~~错误文本~~
  
# 7. 斜体和粗体

使用 \* 和 \*\* 分别表示斜体和粗体。如：
```
这是 *斜体*，这是 **粗体**。
```
效果是：
这是 *斜体*，这是 **粗体**。

# 8. 图片和链接

#### 链接
形式是 \[链接名称\](链接URL) 如：
```
这是[链接](www.quku.xyz)
```
效果是：
这是[链接](www.quku.xyz)

#### 图片
形式是 \!\[图片名称\](图片URL) 如：
```
这是图片![我的头像](http://www.quku.xyz/images/default_avatar.jpg)
```
效果是：
这是图片![图片名字](http://www.quku.xyz/images/default_avatar.jpg)

# 9. 表格

支持表格(请注意对比符号的意思，如----:表示居右)：

```
| 项目        | 价格   |  数量  |
| --------   | -----:  | :----:  |
| 计算机     | \$1600 |   5     |
| 手机        |   \$12   |   12   |
| 管线        |    \$1    |  234  |
```
效果是：

| 项目        | 价格   |  数量  |
| --------   | -----:  | :----:  |
| 计算机     | \$1600 |   5     |
| 手机        |   \$12   |   12   |
| 管线        |    \$1    |  234  |

# 10. 分割线

三个\*即可：
```
***
```
效果：

***

# 11. 特殊字符和`html`标签

如想输入特殊字符如\`,则可以加个反斜杠如\\\`

可直接嵌入`html`标签：
```html
<table>
    <tr>
        <th rowspan="2">值班人员</th>
        <th>星期一</th>
        <th>星期二</th>
        <th>星期三</th>
    </tr>
    <tr>
        <td>李强</td>
        <td>张明</td>
        <td>王平</td>
    </tr>
</table>
```
效果是：
<table>
    <tr>
        <th rowspan="2">值班人员</th>
        <th>星期一</th>
        <th>星期二</th>
        <th>星期三</th>
    </tr>
    <tr>
        <td>李强</td>
        <td>张明</td>
        <td>王平</td>
    </tr>
</table>

# 12. 插件

下面的插件可以解析更多标记，有流程图，甘特图等...（注意：有些标记不是通用的，比如目录语法和脚注语法，可以通过插件来做。）

* 数学公式[MathJax](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)
* 流程图[flowchart](http://adrai.github.io/flowchart.js/)
* [序列图](http://bramp.github.io/js-sequence-diagrams/)
* [甘特图](https://knsv.github.io/mermaid/#gant-diagrams)
* 图标[font-awesome](http://fortawesome.github.io/Font-Awesome/3.2.1/icons/)
