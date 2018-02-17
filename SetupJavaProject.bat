@ECHO OFF
SET /P _inputjar= Please enter a name for your project:
SET /P _inputpath= Please enter the path to the location you wish to work from:
cd "%_inputpath%"
mkdir src
mkdir bin
mkdir jar
rem Making Main
SET /P _inputmain= Please enter a name for your Main class:
echo public class %_inputmain% > .\src\"%_inputmain%".java
echo { >> .\src\"%_inputmain%".java
echo 	 public static void main(String[] args) >> .\src\"%_inputmain%".java
echo 	 { >> .\src\"%_inputmain%".java
echo 		//Main method >> .\src\"%_inputmain%".java
echo 	 } >> .\src\"%_inputmain%".java
echo } >> .\src\"%_inputmain%".java
rem Making Run
echo @ECHO OFF > Run.bat
echo cls >> Run.bat
echo java -cp bin\ %_inputmain% >> Run.bat
rem Making Compile
echo @ECHO OFF > Compile.bat
echo cls >> Compile.bat
echo javac -d bin src\*.java >> Compile.bat
rem Making BuildJar
echo @ECHO OFF > BuildJar.bat
echo cls >> BuildJar.bat
echo cd .\bin >> BuildJar.bat
echo jar cfe "%_inputjar%".jar "%_inputmain%" *.class >> BuildJar.bat
echo cd ..\ >> BuildJar.bat
echo move .\bin\%_inputjar%.jar .\jar >> BuildJar.bat
echo cls >> BuildJar.bat
rem Making BuildJarWithErrorDisplay
echo @ECHO OFF > BuildJarWithErrorDisplay.bat
echo cls >> BuildJarWithErrorDisplay.bat
echo cd .\bin >> BuildJarWithErrorDisplay.bat
echo jar cfe "%_inputjar%".jar "%_inputmain%" *.class >> BuildJarWithErrorDisplay.bat
echo cd ..\ >> BuildJarWithErrorDisplay.bat
echo move .\bin\%_inputjar%.jar .\jar >> BuildJarWithErrorDisplay.bat
rem echo cls >> BuildJar.bat 
rem Making RunJar
echo @ECHO OFF > RunJar.bat
echo cls >> RunJar.bat
echo cd .\jar >> RunJar.bat
echo %_inputjar%.bat >> RunJar.bat
rem Making StartCMD
echo @ECHO OFF > StartCMD.bat
echo cd "%_inputpath%" >> StartCMD.bat
echo start cmd >> StartCMD.bat
cd .\jar
rem Making bat to run the jar
echo @ECHO OFF > "%_inputjar%".bat
echo java -jar "%_inputjar%".jar >> "%_inputjar%".bat
echo pause >> "%_inputjar%".bat
echo cd ..\ >> "%_inputjar%".bat
echo Done
pause