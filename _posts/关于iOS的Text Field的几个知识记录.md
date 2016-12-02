title: 关于iOS的Text Field的几个知识记录
date: 2015-12-01 18:01:00
categories: 娱乐
tags: [Text Field, textFieldShouldRetur, 下一项, Keyboard Type, Return Key]
description:
---
问一：如何设置弹出的输入板
回答：如设置Text Field的属性Keyboard Type为Phone Pad可限定为数字面板。
问二：如何将Select all，Copy，Paste改成全选、复制、粘贴
回答：Info-->Custom iOS Target Properties --> Localization native development region --> China
问三：假如有Text Field A和B，如何A的完成设置成下一项，然后点下一项后去到B，B点完成后键盘隐藏
回答：首先完成改成下一项可以设置Text Field的属性Return Key为next，然后参考下面代码：

```objc
func textFieldShouldReturn(textField: UITextField) -> Bool {
        var shouldReturn = false
        if(textField == self.A) {
            self.A.resignFirstResponder()
            self.B.becomeFirstResponder()
        } else if(textField == self.B) {
            self.B.resignFirstResponder()
            shouldReturn = true
        }
        return shouldReturn
}
```

