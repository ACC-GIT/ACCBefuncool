title: Linux的pipe
date: 2015-12-09 18:09:21
tags: [Linux, pipe]
category: Linux
description:
---
以下是对Linux的pipe函数理解整理：

<!--more-->
### pipe是什么？

> pipe中文名叫管道，是[半双工](/2015/12/09/通讯术语：全双工、半双工、单工/)的，用于进行父子进程间的通讯(IPC形式之一)。

### pipe另外知识：

> 都知道Linux的基本哲学是"一切皆文件",就是说可以有这些函数：`open`, `write`, `read`, `close`。

### 代码理解:
``` c
#include <unistd.h>
#include <sys/types.h>
#include <errno.h>

main() {
	int pipe_fd[2];
	pid_t pid;
	char r_buf[100];
	char w_buf[4];
	char* p_wbuf;
	int r_num;
	int cmd;
	memset(r_buf,0,sizeof(r_buf));
	memset(w_buf,0,sizeof(w_buf));
	p_wbuf=w_buf;
	if(pipe(pipe_fd)<0) {
		printf("pipe create error ");
		return -1;
	}
	if((pid=fork())==0) {
		printf(" ");
		close(pipe_fd[1]);
		sleep(3);
		r_num=read(pipe_fd[0],r_buf,100);
		printf("read num is %d the data read from the pipe is %d ",
			r_num,atoi(r_buf));
		close(pipe_fd[0]);
		exit(0);
	} else if(pid>0) {
		close(pipe_fd[0]);
		strcpy(w_buf,"168");
		if(write(pipe_fd[1],w_buf,100) != -1)
			printf("parent write over ");
		close(pipe_fd[1]);
		printf("parent close fd[1] over ");
		sleep(10);
	}
}
```
> 这段程序可以这样运行，先将此代码保存在pipetest.c中，然后执行gcc -o pipetest pipetest.c，在执行./pipetest，就可以看到输出结果。
> 可以看到`pipe`函数将int数组`pipe_fd`初始化成了管道的两个地址值，注意如下：
> - `pipe_fd[0]`为读管道，`pipe_fd[1]`为写管道
> - fork函数很有意思地生成了一个跟当前进程几乎一样的子进程，他们都执行到pid=fork()这里，其中父进程返回新创建的子进程id，子进程返回0（创建子进程失败返回小于0）。
数据的读出和写入：一个进程向管道中写的内容被管道另一端的进程读出。写入的内容每次都添加在管道缓冲区的末尾，并且每次都是从缓冲区的头部读出数据。
### 运用例子：
比如shell语句的who│wc -l后，相应shell程序将创建who以及wc两个进程和这两个进程间的管道。一个命令的输出直接定向到另一个命令的输入。