@echo off
:: Just run this file and you can test your circ files!
:: Make sure your files are in the directory above this one though!
:: Credits to William Huang and Stephan Kaminsky

::!!!!!!!!!!!!SET the python 2.7 location here. Just repace "nul" with with the directory to python ex: "C:\Python27\python.exe"!!!!!!
set python27path="null"


::Leave this alone
set defname=python2.7
set defpy="C:\Python27\python.exe"

copy alu.circ tests>nul
IF %ERRORLEVEL% NEQ 0 (
    echo.
    ECHO [ERROR] Copy failed: alu.circ to tests!
    if exist tests/alu.circ echo Found an alu.circ file in the test folder already. &goto choicea
    goto end
    :choicea
    set /P c=Do you want to use it [Y/N]?
    if /I "%c%" EQU "Y" goto :cpreg
    if /I "%c%" EQU "N" goto :end
    echo Please only enter y or n!
    echo.
    goto :choicea
)
:cpreg
copy regfile.circ tests>nul
IF %ERRORLEVEL% NEQ 0 (
    echo.
  ECHO [ERROR] Copy failed: regfile.circ to tests!
  if exist tests/regfile.circ echo Found an regfile.circ file in the test folder already. &goto choiceb
    goto end
    :choiceb
    set /P c=Do you want to use it [Y/N]?
    if /I "%c%" EQU "Y" goto :next
    if /I "%c%" EQU "N" goto :end
    echo Please only enter y or n!
    echo.
    goto :choiceb
)
:next
cd tests
::Determining python location
where %defname%>nul
IF %ERRORLEVEL% NEQ 0 goto DefaultLocation
:inPath
echo Python 2.7 found in path!
%defname% sanity_test.py
goto end
:DefaultLocation
ECHO [Warning] Python 2.7 is not in the path! Checking alternative locations...
echo.
if not exist %defpy% goto custloc
echo.
echo [Default Location] Python found!
echo.
%defpy% sanity_test.py
goto end
:custloc
echo [Warning] Python 2.7 was not found in %defpy%. Checking custom location...
echo.
if %python27path%=="null" goto noPython
if not exist %python27path% goto nend
echo.
echo [Custom Location] Python found!
echo.
%python27path% sanity_test.py
goto end
:noPython
echo. 
echo [Error] Please open up the batch script and set the %python27path% with the path to the python 2.7 executable.
echo It could not be found on the system so you need to set it yourself before this will work. 
echo. 
goto end
:nend
echo.
echo [Error] Python 2.7 was not found in %python27path%!.
:end
cd ..
echo.
echo Press any key to exit...
pause>nul
