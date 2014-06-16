@echo off
set jarOne=
set jarTwo=
set HtmlOne=
set HtmlTwo=
set PathOne=
set PathTwo=

IF NOT "%1"=="" (
GOTO auto
)
GOTO manuall
-----------------------------------------------------------------------------------------------

:auto

IF "%1"=="help" (
GOTO autoHelp
)

IF "%8"=="" (
@echo not enogh inputs, please refer to  "joining help"
GOTO END
)



IF "%1"=="-h1" ( set HtmlOne=%2 )
IF "%3"=="-h1" ( set HtmlOne=%4 )
IF "%5"=="-h1" ( set HtmlOne=%6 )
IF "%7"=="-h1" ( set HtmlOne=%8 )

IF "%1"=="-h2" ( set HtmlTwo=%2 )
IF "%3"=="-h2" ( set HtmlTwo=%4 )
IF "%5"=="-h2" ( set HtmlTwo=%6 )
IF "%7"=="-h2" ( set HtmlTwo=%8 )

IF "%1"=="-j1" ( set jarOne=%2 )
IF "%3"=="-j1" ( set jarOne=%4 )
IF "%5"=="-j1" ( set jarOne=%6 )
IF "%7"=="-j1" ( set jarOne=%8 )

IF "%1"=="-j2" ( set jarTwo=%2 )
IF "%3"=="-j2" ( set jarTwo=%4 )
IF "%5"=="-j2" ( set jarTwo=%6 )
IF "%7"=="-j2" ( set jarTwo=%8 )

IF "%1"=="-p1" ( set pathOne=%2 )
IF "%3"=="-p1" ( set pathOne=%4 )
IF "%5"=="-p1" ( set pathOne=%6 )
IF "%7"=="-p1" ( set pathOne=%8 )

IF "%1"=="-p2" ( set pathTwo=%2 )
IF "%3"=="-p2" ( set pathTwo=%4 )
IF "%5"=="-p2" ( set pathTwo=%6 )
IF "%7"=="-p2" ( set pathTwo=%8 )

mkdir backBone\tempFolder
cd backBone
copy "openHTML.class" tempFolder
cd tempFolder

IF "%HtmlOne%"=="" IF "%HtmlTwo%"=="" ( java openHTML %pathOne% %jarOne% %pathTwo% %jarTwo% bothpath )
IF "%PathOne%"=="" IF "%PathTwo%"=="" ( java openHTML %htmlOne% %jarOne% %htmlTwo% %jarTwo% bothHTML )
IF "%HtmlOne%"=="" IF "%PathTwo%"=="" ( java openHTML %pathOne% %jarOne% %htmlTwo% %jarTwo% PathOneHTMLTwo )
IF "%PathOne%"=="" IF "%HtmlTwo%"=="" ( java openHTML %htmlOne% %jarOne% %pathTwo% %jarTwo% HtmlOnePathTwo )
GOTO autoCore
GOTO end
-----------------------------------------------------------------------------------------------


:autoCore
javac -Xlint Combine.java
mkdir app
copy "%jarOne%" app
@echo "%jarOne%"
move combine.class app
cd app
jar xf "%jarOne%"

:pathRemoverJarOne
SET tempJarOne=%jarOne%
SET jarOne=%jarOne:*\=%
IF "%jarOne%"=="%tempJarOne%" ( GOTO pathRemovedJarOne )
GOTO pathRemoverJarOne
:pathRemovedJarOne

echo y | del META-INF
rmdir META-INF
echo y | del "%jarOne%"
cd ..
copy "%jarTwo%" app
cd app
jar xf "%jarTwo%"
echo y | del META-INF
rmdir META-INF

:pathRemoverJarTwo
SET tempJarTwo=%jarTwo%
SET jarTwo=%jarTwo:*\=%
IF "%jarTwo%"=="%tempJarTwo%" ( GOTO pathRemovedJarTwo )
GOTO pathRemoverJarTwo
:pathRemovedJarTwo

echo y | del "%jarTwo%"
jar cf finished.jar *
cd ..
cd ..
cd ..
cd ..
copy "JarProject\backBone\tempFolder\app\finished.jar" JarProject
cd JarProject
rd /s /q "backBone\tempFolder"
GOTO end
-----------------------------------------------------------------------------------------------


:autoHelp
@echo Combines Jar files
@echo Basic style, type run -componet -file
@echo you must specify all files
@echo --------------------------------------------------------------------- 
@echo all componet types -p1 -p2 -h1 -h2 -j1 -j2
@echo J is for the jar location (You have to use both j1 and j2)
@echo P is if you know the path to the starting file in the jar file
@echo h is if you have a html file that has the path
@echo --------------------------------------------------------------------
@echo example (html1, html2, path1, path2, jar1, jar2 you have to supply,
@echo they are the file locations and paths)
@echo '
@echo This command will assume you have a html file for the first Jar and
@echo a path for the second jar
@echo '
@echo joining -h1 html1 -p2 path2 -j1 jar1 -j2 jar2
@echo '
@echo The order that the componets are put does not matter for example
@echo joining -p2 path2 -j1 jar1 -j2 jar2 -h1 html1
@echo means the same thing as above
@echo '
@echo However you do have to specify the componet and then that componet
@echo argument example
@echo -h1 html1 is good
@echo html1 -h1 will crash the program
@echo '
@echo Finally you must have[-j1 and -j2 and [ -p1 or -h1 ] and [ -p2 or -h2 ] ] 

GOTO end
-----------------------------------------------------------------------------------------------































:manuall
cls
@echo "   
@echo "                      ^__^
@echo "     |)|)  ---       (O  O)DDDDDDDDDD===   ==> ---
@echo "    (o_o)  ---      (>>_<<)DDDDDDDDDD   ===    ---
@echo "    (")(") ---         (")(")   (")(")         ---


:start
@echo "
@echo Please enter something to start type "help" if you want help
@echo Jar One
:jarOne
set /P jarOne=:


IF "%jarOne%"=="q!" (
	GOTO end
)
IF "%jarOne%"=="help" (
	GOTO manuallHelp
)

IF NOT EXIST "%jarOne%" (
	@echo jarOne doesnt exsist retry
	GOTO jarOne
)


:findingSorceOne
@echo Do you have a html of a path location of Jar One
@echo Type p for path
@echo Type h for html
set /P deciderOne=:
IF "%deciderOne%"=="q!" (
	GOTO end
)
IF NOT "%deciderOne%"=="p" IF NOT "%deciderOne%"=="h" (
	@echo You need a "p" or a "h"
	GOTO findingSorceOne
)

:GettingFileOne
IF "%deciderOne%"=="p" ( @echo Please enter the path )
IF "%deciderOne%"=="h" ( @echo Please enter the html location )

set /P firstJarData=:
IF "%firstJarData%"=="q!" (
	GOTO end
)
IF "%deciderOne%"=="h" IF NOT EXIST "%firstJarData%" (
@echo html file does not exsist
GOTO GettingFileOne
)


@echo Jar Two
:jarTwo
set /P jarTwo=:


IF "%jarTwo%"=="q!" (
	GOTO end
)
IF "%jarTwo%"=="help" (
	GOTO manuallHelp
)

IF NOT EXIST "%jarTwo%" (
	@echo jarTwo doesnt exsist retry
	GOTO jarTwo
)


:findingSorceTwo
@echo Do you have a html of a path location of Jar Two
@echo Type p for path
@echo Type h for html
set /P deciderTwo=:
IF "%deciderTwo%"=="q!" (
	GOTO end
)
IF NOT "%deciderTwo%"=="p" IF NOT "%deciderTwo%"=="h" (
	@echo You need a "p" or a "h"
	GOTO findingSorceTwo
)

:GettingFileTwo
IF "%deciderTwo%"=="p" ( @echo Please enter the path )
IF "%deciderTwo%"=="h" ( @echo Please enter the html location )

set /P secondJarData=:
IF "%secondJarData%"=="q!" (
	GOTO end
)
IF "%deciderTwo%"=="h" IF NOT EXIST "%secondJarData%" (
@echo html file does not exsist
GOTO GettingFileTwo
)

mkdir backBone\tempFolder
cd backBone
copy "openHTML.class" tempFolder
cd tempFolder

IF "%deciderOne%"=="p" IF "%deciderTwo%"=="p" ( java openHTML %firstJarData% %jarOne% %secondJarData% %jarTwo% bothpath )
IF "%deciderOne%"=="h" IF "%deciderTwo%"=="h" ( java openHTML %firstJarData% %jarOne% %secondJarData% %jarTwo% bothHTML )
IF "%deciderOne%"=="p" IF "%deciderTwo%"=="h" ( java openHTML %firstJarData% %jarOne% %secondJarData% %jarTwo% PathOneHTMLTwo )
IF "%deciderOne%"=="h" IF "%deciderTwo%"=="p" ( java openHTML %firstJarData% %jarOne% %secondJarData% %jarTwo% HtmlOnePathTwo )

GOTO autoCore

GOTO end
-----------------------------------------------------------------------------------------------



:manuallHelp
@echo ---------------------------------------------------------------------
@echo Combines Jar files
@echo Basic style, type run -componet -file
@echo you must specify all files
@echo Type "q!" at anytime to leave.
@echo --------------------------------------------------------------------- 
@echo all componet types -p1 -p2 -h1 -h2 -j1 -j2
@echo J is for the jar location (You have to use both j1 and j2)
@echo P is if you know the path to the starting file in the jar file
@echo h is if you have a html file that has the path
@echo --------------------------------------------------------------------
@echo example (html1, html2, path1, path2, jar1, jar2 you have to supply,
@echo they are the file locations and paths)
@echo '
@echo This command will assume you have a html file for the first Jar and
@echo a path for the second jar
@echo '
@echo -h1 html1 -p2 path2 -j1 jar1 -j2 jar2
@echo '
@echo The order that the componets are put does not matter for example
@echo joining -p2 path2 -j1 jar1 -j2 jar2 -h1 html1
@echo means the same thing as above
@echo '
@echo However you do have to specify the componet and then that componet
@echo argument example
@echo -h1 html1 is good
@echo html1 -h1 will crash the program
@echo '
@echo Finally you must have[-j1 and -j2 and [ -p1 or -h1 ] and [ -p2 or -h2 ] ] 

GOTO start
-----------------------------------------------------------------------------------------------


:end