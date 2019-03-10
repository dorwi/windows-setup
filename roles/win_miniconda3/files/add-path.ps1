Param (
[string]$NewPath = "C:\tools\miniconda3\Scripts"
)

Function Add-Path {
  <#.SYNOPSIS
  PowerShell function to modify Env:Path in the registry
  .DESCRIPTION
  Includes a parameter to append the Env:Path if it does not exist yet
  .EXAMPLE
  Add-Path -NewPath "D:\Downloads"
  #>
  Param (
  [String]$NewPath =""
  )
  Begin {
  #Clear-Host
  } # End of small begin section
  Process {
  #Clear-Host
  $Reg = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
  $OldPath = (Get-ItemProperty -Path "$Reg" -Name PATH).Path
  if($OldPath.Contains($NewPath)){
    # nothing happens
  } else {
    $NewPath = $OldPath + ";" + $NewPath
    Set-ItemProperty -Path "$Reg" -Name PATH -Value $NewPath
  }
# TODO:  
      } #End of Process
}


Add-Path $NewPath
