title: 怎么去除优酷广告
date: 2016-12-05 11:37:25
tags: 奇技
category: 奇技
---

{% cq %} 优酷越来越放肆了，其广告时间从原来十几秒上升到现在几乎两分钟。 {% endcq %}

也不会像别家的广告，可以点击关闭。无法忍受这漫长的广告怎么办？跟我来！

# 去除优酷广告的方法

###### 1. 安装浏览器插件或通过某些限制广告访问的软件

这种方法估计是比较简单，但易被优酷察觉，虽然广告是不播了，但还是要等那么长时间视频才播。

###### 2. 自己修改`hosts`文件

打开`hosts`文件(这个文件在Mac下是在`/private/etc`下，在Windows下大概是在`C:\Windows\System32\drivers\etc`下)，在后面添加如下代码：

````
#优酷
127.0.0.1 atm.youku.com
127.0.0.1 Fvid.atm.youku.com
127.0.0.1 html.atm.youku.com
127.0.0.1 valb.atm.youku.com
127.0.0.1 valf.atm.youku.com
127.0.0.1 valo.atm.youku.com
127.0.0.1 valp.atm.youku.com
127.0.0.1 lstat.youku.com
127.0.0.1 speed.lstat.youku.com
127.0.0.1 urchin.lstat.youku.com
127.0.0.1 stat.youku.com
127.0.0.1 static.lstat.youku.com
127.0.0.1 valc.atm.youku.com
127.0.0.1 vid.atm.youku.com
127.0.0.1 walp.atm.youku.com
```

这样的方式是屏蔽了广告，而且优酷不会察觉（注意前提是之前浏览器没装被优酷识别的插件）。

###### 3. 可以试试这里

<!--more-->

下面只需要将优酷视频的`url`填入，然后提交即可：

{% raw %}
<script type="text/javascript">
    function actionVedio() {
        var url = document.getElementById('url').value;
        var patternReg = /X\w+=*(?=\.)/;
        var result = patternReg.exec(url);
        if (result != null) {
        } else {
            document.getElementById('error').style.display = '';
            return;
        }
        document.getElementById("frame").src = "http://www.haofangyuan.net/youku/videoyk.jsp?token=v&width=620&height=400&auto=yes&id=" + result[0];
    }

    function onInput() {
        document.getElementById('error').style.display = 'none';
    }
</script>
<div style="text-align: center">
    <iframe src="http://www.haofangyuan.net/youku/videoyk.jsp?token=v&width=620&height=400&auto=no&id=XMzQ5MjAzNjg="
            width="620" height="400" marginheight="0" marginwidth="0" frameborder="0" scrolling="no"
            id="frame"></iframe>
    <br/>
    <br/>
    <br/>
    <br/>
    <form action="javascript:actionVedio()" method="get" style="text-align: center">
        视频地址: <input type="url" name="user_email" id="url" oninput="onInput()"/><span
            style="color: red;margin-left: 10px;display: none;" id="error">请确定是优酷视频地址然后重试</span>
    </form>
</div>
{% endraw  %}