title: 利用脚本通过U盟定时给iphone静默推送
date: 2016-08-06 01:04:59
tags: [IOS,脚本]
category: IOS
---

<img src="/images/upush.png" class="full-image" />

#### 先附上脚本（Python）
<!--more-->
```python
#coding=utf-8

import time

import hashlib
import requests
import json
import urllib2

from datetime import datetime
import time
import os
from apscheduler.schedulers.blocking import BlockingScheduler

def md5(s):
    m = hashlib.md5(s)
    return m.hexdigest()

def push_unicast():
    appkey = 'your appkey'
    app_master_secret = 'your app_master_secret'
    device_token = 'your device_token'
    timestamp = int(time.time() * 1000 )
    method = 'POST'
    url = 'http://msg.umeng.com/api/send'
    params = {'appkey': appkey,
              'timestamp': timestamp,
              'device_tokens': device_token,
              'type': 'unicast',
              'production_mode': 'false',
              'payload': {'aps': {'content-available':1}}
              }
    post_body = json.dumps(params)
    print post_body
    sign = md5('%s%s%s%s' % (method,url,post_body,app_master_secret))
    try:
        r = urllib2.urlopen(url + '?sign='+sign, data=post_body)
        print r.read()
    except urllib2.HTTPError,e:
        print e.reason,e.read()
    except urllib2.URLError,e:
        print e.reason

if __name__ == '__main__':
    scheduler = BlockingScheduler()
    scheduler.add_job(push_unicast,'cron',second='*/3',hour='*')
    print 'Press Ctrl+{0} to exit'.format('Break' if os.name == 'nt' else 'C')
    try:
       scheduler.start()
    except KeyboardInterrupt,SystemExit:
            scheduler.shutdown()
```

#### 下面是需要注意的几点

* 注意将代码中的`device_token`、`appkey`等换成自己的。

* `device_token`可通过真机连接Xcode后打断点在`didRegisterForRemoteNotificationsWithDeviceToken`方法处得到。

* 注意python模块apscheduler要3.0以上，可以这样进行安装`pip install apscheduler==3.0`。

* `second='*/3'`表示每隔三秒执行一次，这里可根据需要调整。

* 注意`production_mode`表示是测试模式还是正式，测试模式需要在U盟测试模式添加测试设备。

* 静默推送要求`'aps': {'content-available':1}`，也可以发送普通推送，只需在`aps`里加入`alert`参数即可。