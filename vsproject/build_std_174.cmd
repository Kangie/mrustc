@set MRUSTC_TARGET_VER=1.74
@set RUSTC_VERSION=1.74.0
@set OUTDIR=output-%RUSTC_VERSION%
@set COMMON_ARGS=--vendor-dir ..\rustc-%RUSTC_VERSION%-src\vendor --manifest-overrides ..\rustc-%RUSTC_VERSION%-overrides.toml
@if defined PARLEVEL ( set COMMON_ARGS=%COMMON_ARGS% -j %PARLEVEL% )
@if "%1" == "mmir" (
	set COMMON_ARGS=%COMMON_ARGS% -Z emit-mmir
	set OUTDIR=%OUTDIR%-mmir
)
@set STD_ARGS=--output-dir %OUTDIR% %COMMON_ARGS%
@set STD_ARGS=%STD_ARGS% --script-overrides ..\script-overrides\stable-%RUSTC_VERSION%-windows
@mkdir %OUTDIR%

x64\Release\minipatch.exe ..\rustc-1.74.0-src.patch ..\rustc-1.74.0-src
@if %errorlevel% neq 0 exit /b %errorlevel%

x64\Release\minicargo.exe ..\rustc-%RUSTC_VERSION%-src\library\test %STD_ARGS%
@if %errorlevel% neq 0 exit /b %errorlevel%
x64\Release\minicargo.exe ..\lib\libproc_macro %COMMON_ARGS% --output-dir %OUTDIR%
@if %errorlevel% neq 0 exit /b %errorlevel%