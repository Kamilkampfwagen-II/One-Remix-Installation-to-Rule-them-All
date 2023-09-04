# One Remix Installation to Rule them All

Install remix per game easily which get updated with RuneStorm's [RTX Remix Downloader](https://github.com/Kowlin/RTX-Remix-Downloader/)
This script creates symbolic links pointing to the `remix` folder created by **RTX Remix Downloader**

# Setup:
1. Put the `RTX.Remix.Downloader.exe` into a fixed location i.e. `C:/RTX Remix/RTX.Remix.Downloader.exe`
2. You need to specify the path for the script:
    - Uncomment the line `$env:REMIXPATH = "C:/remix"` and set the string to desired path
    or
   - Set the environmental variable `REMIXPATH` to desired path
    i.e. `C:/RTX Remix/remix`

3. Put the https://github.com/Kamilkampfwagen-II/One-Remix-Installation-to-Rule-them-All/blob/main/Microsoft.PowerShell_profile.ps1 file into `%USERPROFILE%\Documents\WindowsPowerShell`

# How to Use:
Open up powershell as admin then enter the command: `Install-Remix "GAME PATH"`
You can drag-drop the adress bar to powershell window which will paste it's path. Or you can run the powershell in the desired path and simply type `.` for the path.
- If the game executable is 64 bit, enter the argument `-x64`

# Notes:
- Administrator privilege is required for creating symbolic links, consider using https://github.com/gerardog/gsudo, an unix-like sudo command to elevate the current shell instance.
- Most games should work fine with symbolic links since looking for the `d3d9.dll` library is a universal behaviour and is not defined by the game logic.
- You can still configure the bridge per game since the script doesn't use symbolic link for the `.trex` folder, just for its contents.
- Logs are still generated per game.
- You can put a `dxvk.conf` into remix folder that contains your preferred settings (like turning off vsync) which will be copied to game path during installation.

# Showcase:
![showcase](https://github.com/Kamilkampfwagen-II/One-Remix-Installation-to-Rule-them-All/assets/84380947/4f9480c4-df8c-4a62-ac89-1344e13a275b)
