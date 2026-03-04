' 改进版 - 增加超时和重试机制
Set WshShell = WScript.CreateObject("WScript.Shell")

' 先等浏览器启动
WScript.Sleep 2000

' 尝试发送回车，如果失败就重试
Dim retryCount, maxRetries
maxRetries = 5
retryCount = 0

Do While retryCount < maxRetries
    WshShell.SendKeys "{ENTER}"
    WScript.Sleep 1000  ' 每次尝试后等1秒
    
    ' 简单检测：如果页面标题变了（登录成功后通常会跳转）
    On Error Resume Next
    WshShell.AppActivate "Microsoft Edge"
    If Err.Number = 0 Then
        ' 如果能激活窗口，说明还在
        retryCount = retryCount + 1
    Else
        ' 窗口可能关了，退出循环
        Exit Do
    End If
    On Error GoTo 0
Loop

' 不管成功与否，最后尝试关闭
WScript.Sleep 1000
WshShell.SendKeys "%{F4}"