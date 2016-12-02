title: GIT有时候.gitignore不起作用的问题
date: 2015-07-07 15:45:00
categories: 娱乐
tags: [.gitignore, GIT, bin, 提交, 生成]
description:
---
现象：明明已经在.gitignore文件了加了/bin/，更新提交的时候还是显示bin目录下文件。
原因：可能是已经提交了，有记录了，所以不起作用。
解决：先删除bin目录再提交，等再次生成的时候这个目录已经有减号了，起了作用。
