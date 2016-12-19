---
date: '2016-12-19 15:59 +0800'
published: true
title: Android性能优化
category:
  - Android
tags:
  - Android
  - 性能优化
---
## 工具

{% cq %} 工欲善其事，必先利其器。 {% endcq %}

如何充分地利用工具来帮我们进行性能分析，是值得深入研究的。`AS`给我们提供了良好的开发环境，你真的对它充分了解了吗？

各种各样的性能分析工具和教程五花八门，其实一个好用的工具就集成在AS里面，多点点`Android Monitor`视图就知道。有没有想过`Captrues`栏是用来干嘛的？有没有点过工具上的问号？那里才是一手知识。

顺便说，前段时间谷歌放开了一些网站，凡是访问`developer.android.com`的，可以将其改为`developer.android.google.cn`即可无需翻墙访问。又顺便说，作为一个新时代的能者，不要再抱怨某墙，事情存在必有其合理性。王小波说得对：人的一切痛苦，本质上是对自己的无能的愤怒。不管外在如何，首先从自己身上寻找优化的地方，总会有优化的地方不是吗？

下图是用AS获取的GPU分析图，我们从这可以大致看到GPU的使用情况，进而对应用进行相应优化。

{% fi http://afirsraftgarrier.qiniudn.com/am-gpumon.png %}