@echo off
chcp 65001 >nul
title 校园网自动连接脚本
cd /d "%~dp0"

:start
cls
echo ========================================
echo           校园网自动连接
echo ========================================
echo.
echo 正在检测网络环境 请稍候...
echo.

:: ========== 第一步：检测是否能上网 ==========
echo [1/3] 检测互联网连接...
ping -n 1 www.baidu.com >nul 2>&1

if %errorlevel%==0 (
    echo 互联网连接正常 可以上网
    echo.
    echo 脚本将自动退出...
    timeout /t 3 >nul
    exit /b 0
) else (
    echo 无法访问互联网
    echo.
)

:: ========== 第二步：检测是否在校园网环境 ==========
echo [2/3] 检测校园网环境...

curl -s --connect-timeout 3 -I http://eportal.hhu.edu.cn >nul 2>&1

if %errorlevel%==0 (
    echo 检测到河海大学校园网环境
    echo.
) else (
    echo 未检测到校园网环境
    pause
    exit /b 1
)

:: ========== 第三步：打开登录页面并自动点击 ==========
echo [3/3] 正在启动自动登录...
echo.

:: 打开浏览器
echo 正在打开浏览器...
start msedge "http://eportal.hhu.edu.cn"

:: 等待页面加载，然后模拟回车并关闭
echo 正在自动完成登录...
timeout /t 2 >nul

:: 调用VBS脚本模拟回车和关闭浏览器
wscript.exe "click_enter.vbs"

:: ========== 第四步：等待并验证网络 ==========
echo 正在验证登录是否成功...
timeout /t 2 >nul

ping -n 1 www.baidu.com >nul 2>&1
if %errorlevel%==0 (
    echo 登录成功 网页已自动关闭 可以正常上网
) else (
    echo 暂时无法访问互联网，请手动检查
)

:: 自动退出，不需要pause
timeout /t 3 >nul
exit