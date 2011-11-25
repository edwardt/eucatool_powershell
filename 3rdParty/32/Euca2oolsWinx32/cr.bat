echo on
set archive=Euca2oolsWinx32

pushd 
echo "Creating console version"
copy /b ..\7z920_extra\7zSD.sfx + config.txt + Euca2oolsWinx32.7z Euca2oolsWinx32_con.exe
echo "Done Creating console version"
popd

pushd
echo "Creating gui version"
copy /b ..\7z920_extra\7zS2.sfx + config.txt + Euca2oolsWinx32.7z Euca2oolsWinx32_gui.exe
echo "Done Creating gui version"
popd
