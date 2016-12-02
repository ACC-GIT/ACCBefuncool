title: eclipse+CDT调试segmentation fault错误
date: 2015-06-13 16:49:00
categories: 娱乐
tags: [eclipse, debug, CC++, VMA, segmentation fault]
description:
---
### 先来看两段代码--
错误代码：


```cpp
#include "string.h"
#include <stdlib.h>
#include <stdio.h>

void test(char ** dest, char * src, int n) {
	(*dest) = (char*) malloc(sizeof(char) * n);
	strcpy(*dest, src);
}

int main(int argc, char** args) {
	char ** p = NULL;
	char str[] = "test segmentation fault";
	int len = sizeof(str);
	test(p, str, len);
}
```

正确代码：


```cpp
#include "string.h"
#include <stdlib.h>
#include <stdio.h>

void test(char ** dest, char * src, int n) {
	(*dest) = (char*) malloc(sizeof(char) * n);
	strcpy(*dest, src);
}

int main(int argc, char** args) {
	char * p = NULL;
	char str[] = "test segmentation fault";
	int len = sizeof(str);
	test(&p, str, len);
}

```
如果用`coredump+gdb`调试的话，会发现错误程序出现常见的`segmentation fault`错误。
原因：这种错误往往是程序访问到了没有权限访问或者没有经过MMU映射的地址空间所致。
分析：一个应用程序启动时，系统会为其建立一个进程（Process），这个进程有独立的虚拟内存空间（VMA:Vertual memory area)，如下图：
![](http://img.blog.csdn.net/20150613164741179?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
如上图，当应用程序进程访问红线标注的区域时，都会发生segmentation fault错误。
调试：接下来用eclipse的C/C++版（或者eclipse安装CDT）进行调试上面错误例子，图如下：
![](http://img.blog.csdn.net/20150613161818926?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
我们看到当我们用eclipse试图访问地址为0x0的指针*p的值时，出了错Cannot access memory at address 0x0。（验证了我们上面的分析，0x0地址无权限访问）
错析：现在来分析分析这个错误程序出错在哪里。
1）char ** p = NULL;这句话执行后指向指针的指针p的value为0x0，即*p指针的地址是0x0。
2）(*dest) = (char*) malloc(sizeof(char) * n);这句话分析：首先等式右边(char*) malloc(sizeof(char) * n)执行是没有错的，得到一个分配后的地址值，接下来将地址值赋给左边的*dest时问题出现了，通过前面分析知道*dest指针的地址也就是上面*p指针的地址是0x0，这个地址通过前面分析是无权访问的，应用程序赋值也就是进行了访问，这就是问题根源。
正确：现在来对比下正确的，如下图：
![](http://img.blog.csdn.net/20150613170130876?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
可以看到*dest也就是&p的地址值是0x28ff08，这个地址是可以访问的，所以当我们将分配到的地址值赋给*dest是完全没问题的。
