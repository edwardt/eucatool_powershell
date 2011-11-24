echo on
$P$_$+$G
pushd .
call Win32OpenSSL-0_9_8r.msi
popd
pushd
call vcredist_x86.exe
popd
pushd
call putty-0.61-installer.exe
popd

pushd
call python-2.7.2.msi
set PATH=%PATH%;C:\Python27
echo %PATH%
popd

pushd
call "M2Crypto-0.20.2.win32-py2.7.exe"
popd

pushd
cd boto-1.9b
dir 
call python setup.py build
call python setup.py install
cd ..
popd


pushd 
cd euca2ools-1.3.1
cd euca2ools
call python setup.py build
call python setup.py install
cd ..
cd ..
popd
