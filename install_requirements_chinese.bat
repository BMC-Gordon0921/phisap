@echo off

echo ����Ϊ��Ҫ��װ��ģ��
for /f %%j in (requirements.txt) do echo %%j
echo ��װ��ʼ
for /f %%i in (requirements.txt) do pip install %%i
echo ��ʾ�Ѱ�װ��ģ��
pip list
pause
