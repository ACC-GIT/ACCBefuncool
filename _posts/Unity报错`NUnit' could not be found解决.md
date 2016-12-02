title: Unity报错`NUnit' could not be found解决
date: 2015-07-12 22:32:00
categories: 娱乐
tags: [单元测试, Unity, MonoDevelop, NUnit, Editor]
description:
---
情况：使用Unity，在mono建立一个NUnit测试文件时，发现在mono下可以测试，但在Unity下报错...the type or namespace name `NUnit' could not be found. Are you missing a using directive or an assembly reference?
原因：unity的NUnit单元测试必须在Editor模式下执行，所以用Unity的话这个测试文件必须在Editor文件夹下。
解决：可以在Assets文件夹下建立Editor文件夹，在里面写NUnit。
