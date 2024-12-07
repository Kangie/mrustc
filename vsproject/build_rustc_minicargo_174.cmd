@call build_std_174.cmd
@if %errorlevel% neq 0 exit /b %errorlevel%

@mkdir %OUTDIR%\rustc-build
@set RUST_CHECK=1
@set RUSTC_INSTALL_BINDIR=bin
@set CFG_RELEASE=1.74.0
@set CFG_RELEASE_CHANNEL=stable
@set CFG_COMPILER_HOST_TRIPLE=x86_64-pc-windows-msvc
x64\Release\minicargo.exe ..\rustc-%RUSTC_VERSION%-src\compiler\rustc -L %OUTDIR% --output-dir %OUTDIR%\rustc-build %COMMON_ARGS%
@if %errorlevel% neq 0 exit /b %errorlevel%