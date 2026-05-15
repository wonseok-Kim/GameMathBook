@echo off

@echo:
@echo [SoftRenderer Project Generator]
@echo -------------------------------------------------
PUSHD %~dp0
@echo Removing previous project folder.
IF EXIST "Project" rd "Project" /s /q
@echo:
@echo Done!
@echo:
@echo -------------------------------------------------
IF NOT EXIST "Project" @echo Creating a new project folder.
IF NOT EXIST "Project" md Project
IF NOT EXIST "Project" @echo:
cd Project
@echo:
@echo Done!
@echo:
@echo -------------------------------------------------
@echo Running CMAKE script.
@echo:

set "CMAKE_EXE="
set "CMAKE_GENERATOR=Visual Studio 17 2022"

IF EXIST "%ProgramFiles%\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" (
    set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
    set "CMAKE_GENERATOR=Visual Studio 18 2026"
)
IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\18\Professional\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" (
    set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\18\Professional\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
    set "CMAKE_GENERATOR=Visual Studio 18 2026"
)
IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\18\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" (
    set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\18\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
    set "CMAKE_GENERATOR=Visual Studio 18 2026"
)
IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" (
    set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
    set "CMAKE_GENERATOR=Visual Studio 18 2026"
)

IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles%\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" set "CMAKE_EXE=%ProgramFiles%\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
IF NOT DEFINED CMAKE_EXE IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" FOR /F "usebackq tokens=*" %%i IN (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -find Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe`) DO set "CMAKE_EXE=%%i"
IF DEFINED CMAKE_EXE ECHO "%CMAKE_EXE%" | findstr /I "\\Microsoft Visual Studio\\18\\" >nul && set "CMAKE_GENERATOR=Visual Studio 18 2026"

IF NOT DEFINED CMAKE_EXE (
    @echo Visual Studio bundled CMake was not found.
    @echo Please install the Visual Studio CMake tools component.
    POPD
    PAUSE
    EXIT /B 1
)

@echo Using CMake: %CMAKE_EXE%
@echo Using Generator: %CMAKE_GENERATOR%
"%CMAKE_EXE%" -G "%CMAKE_GENERATOR%" ..\

@echo:
@echo Done!
@echo:
@echo -------------------------------------------------
@echo A new solution file is generated in %~dp0Project
@echo:
POPD
PAUSE
