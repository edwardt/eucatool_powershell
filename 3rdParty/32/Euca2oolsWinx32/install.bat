echo on
echo "Going to kick off various installers will take a few moments ... "
$P$_$+$G
pushd .
echo "Done building and installation Win32OpenSSL-0_9_8r"
call Win32OpenSSL-0_9_8r.msi
echo "Done building and installation Win32OpenSSL-0_9_8r"
popd

pushd
echo "Start building and installation Visual C++ distribution vcredist_x86"
call vcredist_x86.exe
echo "Done building and installation Visual C++ distribution vcredist_x86"
popd

pushd
echo "Start building and installation putty-0.61"
call putty-0.61-installer.exe
echo "Done building and installation putty-0.61"
popd

pushd
echo "Start building and installation python-2.7.2"
call python-2.7.2.msi
set PATH=%PATH%;C:\Python27
echo %PATH%
echo "Done building and installation python-2.7.2"
popd

pushd
echo "Start building and installation M2Crypto-0.20.2.win32-py2.7"
call "M2Crypto-0.20.2.win32-py2.7.exe"
echo "Start building and installation M2Crypto-0.20.2.win32-py2.7"
popd

pushd
echo "Start building and installation boto-1.9b"
cd boto-1.9b
dir 
call python setup.py build
call python setup.py install
cd ..
echo "Done building and installation boto-1.9b"
popd


pushd 
echo "Start building and installation euca2ools-1.3.1"
cd euca2ools-1.3.1
cd euca2ools
call python setup.py build
call python setup.py install
cd ..
cd ..
echo "Done building and installation euca2ools-1.3.1"
popd


pushd
echo "Removing files no longer needed"
del /f ./Win32OpenSSL-0_9_8r.msi
del /f ./vcredist_x86.exe
del /f ./putty-0.61-installer.exe
del /f ./python-2.7.2.msi
del /f ./M2Crypto-0.20.2.win32-py2.7.exe
echo "Files removal Done"
popd
pause 5
