@ECHO OFF
SET /P _inputjar= Please enter a name for your project:
SET /P _inputpath= Please enter the path to the location you wish to work from:
if exist "%_inputpath%" ( 
    cd "%_inputpath%" 
) else ( 
    mkdir "%_inputpath%" && cd "%_inputpath%"
)
mkdir src
mkdir bin
mkdir jar
rem Making Main
SET /P _inputmain= Please enter a name for your Main class:
echo public class %_inputmain%> .\src\"%_inputmain%".java
echo.>> .\src\"%_inputmain%".java
echo {>> .\src\"%_inputmain%".java
echo 	public static void main(String[] args)>> .\src\"%_inputmain%".java
echo 	{>> .\src\"%_inputmain%".java
echo 		//Main method>> .\src\"%_inputmain%".java
echo 	}>> .\src\"%_inputmain%".java
echo }>> .\src\"%_inputmain%".java
rem Making Run
echo @ECHO OFF > Run.bat
echo java -cp bin\ %_inputmain% >> Run.bat
rem Making Compile
echo @ECHO OFF > Compile.bat
echo powershell.exe "Get-ChildItem -Recurse src\*.java | Resolve-Path -Relative" ^> src.txt >> Compile.bat
echo javac -d bin @src.txt >> Compile.bat
echo del src.txt >> Compile.bat
rem Making BuildJar
echo @ECHO OFF > BuildJar.bat
echo cd .\bin >> BuildJar.bat
echo powershell.exe "Get-ChildItem -Recurse .\*.class | Resolve-Path -Relative" ^> bin.txt >> BuildJar.bat
echo jar cfe "%_inputjar%".jar "%_inputmain%" @bin.txt >> BuildJar.bat
echo del bin.txt >> BuildJar.bat
echo cd ..\ >> BuildJar.bat
echo move .\bin\%_inputjar%.jar .\jar ^>nul >> BuildJar.bat
rem Making RunJar
echo @ECHO OFF > RunJar.bat
echo cd .\jar >> RunJar.bat
echo %_inputjar%.bat >> RunJar.bat
echo cd .. >> RunJar.bat
rem Making StartCMD
echo @ECHO OFF > StartCMD.bat
echo cd "%_inputpath%" >> StartCMD.bat
echo start cmd >> StartCMD.bat
cd .\jar
rem Making bat to run the jar
echo @ECHO OFF > "%_inputjar%".bat
echo java -jar "%_inputjar%".jar >> "%_inputjar%".bat
echo echo.%%cmdcmdline%% ^| find /I "%%~0" ^>nul >> "%_inputjar%".bat
echo if not errorlevel 1 pause >> "%_inputjar%".bat
cd ..\..\
echo Done
rem Pause if run from GUI
echo.%cmdcmdline% | find /I "%~0" >nul
if not errorlevel 1 pause
