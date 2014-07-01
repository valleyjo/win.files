
if exist C:\Chocolatey\nul goto :dev
echo ----- Installing Chocolatey -----
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin

:dev
IF EXIST C:\dev goto :instGit
echo ----- Making Local Dev Directory (c:\dev) -----
mkdir C:\dev

:instGit
::if exist %ProgramFiles(x86)%\Git\nul goto :clone
::echo ----- Installing Git-----
::cinst git

:clone
if exist c:\dev\win.files goto :runSetup
echo ----- Cloneing win.files -----
path=%path%;C:\Program Files (x86)\Git\bin
git clone https://github.com/valleyjo/win.files.git c:\dev

:runSetup
echo ----- Running Initial Setup -----
C:\dev\win.files\install.cmd

:eof