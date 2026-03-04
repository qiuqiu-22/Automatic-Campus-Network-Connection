@echo off
chcp 65001 >nul
title 河海大学校园网自动登录工具 - 安装程序
cd /d "%~dp0"


:: ========================================
::  校园网自动登录工具 - 一键安装脚本
:: ========================================
cls
echo.
echo ========================================
echo         校园网自动登录安装工具
echo ========================================
echo.
echo  本工具将自动完成以下配置
echo  复制文件
echo  添加创建桌面快捷方式（可选）
echo  添加开机自启（可选）
echo.


:: ========== 第一步：请求管理员权限 ==========
echo 正在请求管理员权限...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 需要管理员权限才能安装到C盘，请右键选择"以管理员身份运行"
    pause
    exit /b 1
)
echo 已获得管理员权限
echo.


:: ========== 第二步：创建安装目录 ==========
set INSTALL_DIR=C:\Program Files\Automatic Campus Network Connection
echo 目标安装路径：%INSTALL_DIR%

if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
    echo 创建安装目录成功
) else (
    echo 安装目录已存在
)


:: ========== 第三步：复制文件 ==========
echo.
echo 正在复制文件...
copy /Y "Automatic Campus Network Connection.bat" "%INSTALL_DIR%\" >nul
copy /Y "click_enter.vbs" "%INSTALL_DIR%\" >nul
copy /Y "README.md" "%INSTALL_DIR%\" >nul
echo 文件复制完成


:: ========== 第四步：创建桌面快捷方式 ==========
::echo.
::echo 正在创建桌面快捷方式...

:: 获取桌面路径
::for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop" 2^>nul') do set DESKTOP=%%j
::if "%DESKTOP%"=="" set DESKTOP=%USERPROFILE%\Desktop
::echo 桌面文件夹: %DESKTOP%
:: 使用PowerShell创建快捷方式
::powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%DESKTOP%\Automatic Campus Network Connection.lnk'); $s.TargetPath = '%INSTALL_DIR%\Automatic Campus Network Connection.bat'; $s.WorkingDirectory = '%INSTALL_DIR%'; $s.Description = '河海大学校园网自动登录工具'; $s.Save()" >nul
::echo ✅ 桌面快捷方式创建成功



:: ========== 第五步：询问是否添加开机自启 ==========
echo.
echo 正在添加开机自启...

:: 获取启动文件夹路径
set STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
echo 启动文件夹: %STARTUP%

:: 创建快捷方式
powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%STARTUP%\Automatic Campus Network Connection.lnk'); $s.TargetPath = '%INSTALL_DIR%\Automatic Campus Network Connection.bat'; $s.WorkingDirectory = '%INSTALL_DIR%'; $s.Description = '河海大学校园网自动登录工具'; $s.Save()" >nul

echo ✅ 开机自启设置成功

:: ========== 第六步：安装完成 ==========
echo.
echo ========================================
echo               安装完成
echo ========================================
echo.
echo  安装路径：%INSTALL_DIR%
echo.
echo  首次使用前请先手动登录一次校园网
echo  让浏览器记住账号密码，之后就能全自动啦！
echo.
echo 按任意键退出安装程序...
pause >nul
exit