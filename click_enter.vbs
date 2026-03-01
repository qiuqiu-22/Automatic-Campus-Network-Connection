' 自动按下回车键并关闭浏览器的脚本
Set WshShell = WScript.CreateObject("WScript.Shell")
WScript.Sleep 1000
WshShell.SendKeys "{ENTER}"

WScript.Sleep 500

' 发送 Alt+F4 关闭当前浏览器标签页
WshShell.SendKeys "%{F4}"