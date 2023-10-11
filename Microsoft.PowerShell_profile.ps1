function Install-Remix {
   param (
       [Parameter(Mandatory=$true, ValueFromPipeline=$True, ValueFromPipelineByPropertyName=$True)]
       [string]$GamePath,
       [switch]$x64 = $false
   )

   $ErrorActionPreference = 'Stop'

   # $env:REMIXPATH = "C:/remix"
   if (!$env:REMIXPATH) {throw 'Please set environmental variable REMIXPATH to remix folder path.'}
   if ($env:REMIXPATH[-1] -eq '/' -or $env:REMIXPATH[-1] -eq '\') {
      $env:REMIXPATH = $env:REMIXPATH.Substring(0, $env:REMIXPATH.Length -1)
   }
   if (!(Test-Path $env:REMIXPATH)) {throw "Cannot find path '$env:REMIXPATH' because it does not exist."}


   if ($GamePath[-1] -eq '/' -or $GamePath[-1] -eq '\') {
       $GamePath = $GamePath.Substring(0, $GamePath.Length -1)
   }
   if (!(Test-Path $GamePath)) {throw "Cannot find path '$GamePath' because it does not exist."}


   if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
      throw 'Administrator privilege required for this operation.'
   }

   # Installation begins:
   if (!(Test-Path "$GamePath/dxvk.conf")) {
      Copy-Item -Path "$env:REMIXPATH/dxvk.conf" -Destination "$GamePath/dxvk.conf" -ErrorAction Ignore
   }

   if ($x64) {
      # 64 bit installation
      Get-ChildItem -Path "$env:REMIXPATH/.trex" -Exclude 'NvRemixBridge.exe','*.log','*.dmp','*.txt','*.conf' | ForEach-Object {
         if (!(Test-Path "$GamePath/$($_.Name)")) {
            New-Item -Type SymbolicLink -Path "$GamePath/$($_.Name)" -Target $_.FullName | Out-Null
         }
      }
      return
   }

   # 32 bit installation
   New-Item -ItemType Directory "$GamePath/.trex" -Force | Out-Null
   Copy-Item -Path "$env:REMIXPATH/.trex/bridge.conf" -Destination "$GamePath/.trex/bridge.conf" -ErrorAction Ignore

   if (!(Test-Path "$GamePath/d3d9.dll")) {
      New-Item -Type SymbolicLink -Path "$GamePath/d3d9.dll" -Target "$env:REMIXPATH/d3d9.dll" | Out-Null
   }

   Get-ChildItem -Path "$env:REMIXPATH/.trex" -Exclude '*.log','*.dmp','*.txt','*.conf' | ForEach-Object {
      if (!(Test-Path "$GamePath/.trex/$($_.Name)")) {
         New-Item -Type SymbolicLink -Path "$GamePath/.trex/$($_.Name)" -Target $_.FullName | Out-Null
      }
   }

}
