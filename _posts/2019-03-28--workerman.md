---
date: '2019-03-28 15:20 +0800'
published: true
title: 如何处理workerman内存和连接数越积越多问题
category:
  - PHP
  - WORKERMAN
tags:
  - 内存清理
---
## 问题

在使用workerman的过程中，会遇到异常连接（断掉后不会自动清理实例）越积越多的情况，导致服务器内存溢出，连接数越来越多，处理速度越来越慢。

## 解决方法

给每个连接定义一个时间变量，有消息操作就将时间进行更新。然后当新连接来的时候遍历一下所有连接，剔除某些长时间不操作的连接。

```
...
$tcp_worker->onMessage = function ($connection, $data) use ($tcp_worker) {
	...
	$connection->time = time();
    ...
};
...
$tcp_worker->onConnect = function ($connection) use ($tcp_worker) {
	...
    $time = time();
    $connection->time = $time;
    foreach ($tcp_worker->connections as $connectionTemp) {
        if ($time - $connectionTemp->time > 60 * 5) {//5分钟不操作的话，进行清理释放内存
            $connectionTemp->destroy();
        }
    }
    ...
};
...
```