mainJarPath=
hiddenJarPath=
# TODO: Can look in HTML file with applet tag or in the jar's manifest file for entry points
mainJarEntry=
hiddenJarEnty=
# TODO: Get name from manifest file or from command line.
mainJarName=

mkdir temp
cd temp

jar xf $mainJarPath
jar xf $hiddenJarPath

cp ../src/Combine.java ./

javac -Xlint -cp . Combine.java

echo Application-Name: $mainJarName > Manifest.txt
echo Permissions: all-permissions >> Manifest.txt
jar cfm combine.jar Manifest.txt *

# TODO: allow specifying own signing certificate
# Need to have a cert named "combine.keystore" containing a certificate with alias "combine"
jarsigner combine.jar combine -keystore combine.keystore
echo Make sure the following line says "jar verified."
jarsigner -verify combine.jar

mv combine.jar ../
rm Combine.java Combine.class Manifest.txt
cd ..
rmdir -rf temp

echo <!-- Copy and paste this into a web page and put "combine.jar" in the same directory as the web page. -->
echo <applet code="Combine.class" archive="combine.jar">
echo     <param name="applet-main-entry" value="$mainJarEntry" />
echo     <param name="applet-hidden-entry" value="$hiddenJarEntry" />
echo     <!-- param name="main-example" value="This parameter would be visible to the main applet as 'example'." -->
echo     <!-- param name="hidden-example" value="This parameter would be visible to the hidden applet as 'example`'." -->
echo </applet>