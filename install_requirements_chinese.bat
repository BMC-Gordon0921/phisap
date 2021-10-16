@echo off

echo 以下为将要安装的模块
for /f %%j in (requirements.txt) do echo %%j
echo 安装开始
for /f %%i in (requirements.txt) do pip install %%i
echo 显示已安装的模块
pip list
pause
