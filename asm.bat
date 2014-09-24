SET SRCFILE=bentro3.asm

asmn64 /P %SRCFILE%,intro.bin,intro.sym,intro.lst >intro.ERR
if errorlevel 1 goto end

COPY /b header + intro.bin intro.raw
swap intro.raw intro.v64
ias --crc -a 0x80310000 -z 8 intro.v64
64drive -l intro.v64
:end
