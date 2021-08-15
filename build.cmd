@echo off

set CLANG="C:\Program Files\LLVM\bin\clang.exe"
set LLD="C:\Program Files\LLVM\bin\lld-link.exe"
pushd %~dp0

mkdir msvc-with
mkdir clang-with
mkdir msvc-without
mkdir clang-without

%CLANG% -S -g -gcodeview -O0 -c foo.cpp -o clang-with\foo.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c baz.cpp -o clang-with\baz.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c util.cpp -o clang-with\util.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c bar.cpp -o clang-with\bar.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c main.cpp -o clang-with\main.asm || goto :error
%CLANG% -g -gcodeview -O0 -c foo.cpp -o clang-with\foo.o || goto :error
%CLANG% -g -gcodeview -O0 -c baz.cpp -o clang-with\baz.o || goto :error
%CLANG% -g -gcodeview -O0 -c util.cpp -o clang-with\util.o || goto :error
%CLANG% -g -gcodeview -O0 -c bar.cpp -o clang-with\bar.o || goto :error
%CLANG% -g -gcodeview -O0 -c main.cpp -o clang-with\main.o || goto :error
%CLANG% /debug clang-with\foo.o clang-with\baz.o clang-with\util.o clang-with\bar.o clang-with\main.o -o clang-with\app-clang-with.exe || goto :error

%CLANG% -S -g -gcodeview -fno-exceptions -O0 -c foo.cpp -o clang-without\foo.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c bar.cpp -o clang-without\bar.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c baz.cpp -o clang-without\baz.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c util.cpp -o clang-without\util.asm || goto :error
%CLANG% -S -g -gcodeview -O0 -c main.cpp -o clang-without\main.asm || goto :error
%CLANG% -g -gcodeview -O0 -fno-exceptions -c foo.cpp -o clang-without\foo.o || goto :error
%CLANG% -g -gcodeview -O0 -c bar.cpp -o clang-without\bar.o || goto :error
%CLANG% -g -gcodeview -O0 -c baz.cpp -o clang-without\baz.o || goto :error
%CLANG% -g -gcodeview -O0 -c util.cpp -o clang-without\util.o || goto :error
%CLANG% -g -gcodeview -O0 -c main.cpp -o clang-without\main.o || goto :error
%CLANG% /debug clang-without\foo.o clang-without\baz.o clang-without\util.o clang-without\bar.o clang-without\main.o -o clang-without\app-clang-without.exe || goto :error

cl /nologo /EHsc /c /ZI /Fdmsvc-with\foo.pdb /Famsvc-with\foo.asm /FAs /Fomsvc-with\foo.obj foo.cpp || goto :error
cl /nologo /EHsc /c /ZI /Fdmsvc-with\bar.pdb /Famsvc-with\bar.asm /FAs /Fomsvc-with\bar.obj bar.cpp || goto :error
cl /nologo /EHsc /c /ZI /Fdmsvc-with\baz.pdb /Famsvc-with\baz.asm /FAs /Fomsvc-with\baz.obj baz.cpp || goto :error
cl /nologo /EHsc /c /ZI /Fdmsvc-with\util.pdb /Famsvc-with\util.asm /FAs /Fomsvc-with\util.obj util.cpp || goto :error
cl /nologo /EHsc /c /ZI /Fdmsvc-with\main.pdb /Famsvc-with\main.asm /FAs /Fomsvc-with\main.obj main.cpp || goto :error
link /nologo /DEBUG /OUT:msvc-with\app-msvc-with.exe msvc-with\main.obj msvc-with\foo.obj msvc-with\bar.obj msvc-with\baz.obj msvc-with\util.obj || goto :error

cl /nologo /c /ZI /EHsc /Fdmsvc-without\foo.pdb /Famsvc-without\foo.asm /FAs /Fomsvc-without\foo.obj foo.cpp || goto :error
cl /nologo /c /ZI /EHs- /Fdmsvc-without\bar.pdb /Famsvc-without\bar.asm /FAs /Fomsvc-without\bar.obj bar.cpp || goto :error
cl /nologo /c /ZI /EHs- /Fdmsvc-without\baz.pdb /Famsvc-without\baz.asm /FAs /Fomsvc-without\baz.obj baz.cpp || goto :error
cl /nologo /c /ZI /EHs- /Fdmsvc-without\util.pdb /Famsvc-without\util.asm /FAs /Fomsvc-without\util.obj util.cpp || goto :error
cl /nologo /c /ZI /EHsc /Fdmsvc-without\main.pdb /Famsvc-without\main.asm /FAs /Fomsvc-without\main.obj main.cpp || goto :error
link /nologo /DEBUG /OUT:msvc-without\app-msvc-without.exe msvc-without\main.obj msvc-without\foo.obj msvc-without\bar.obj msvc-without\baz.obj msvc-without\util.obj || goto :error

@echo Success
popd
exit /b 0

:error
@echo Failure
popd
exit /b !errorlevel!

