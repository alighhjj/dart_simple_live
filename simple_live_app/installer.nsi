!define APP_NAME "Simple Live"
!define APP_VERSION "1.9.1"
!define APP_EXECUTABLE "simple_live_app.exe"

# Include Modern UI
!include "MUI2.nsh"

# General
Name "${APP_NAME} ${APP_VERSION}"
OutFile "simple_live_installer.exe"
InstallDir "$PROGRAMFILES\Simple Live"
InstallDirRegKey HKCU "Software\Simple Live" ""
RequestExecutionLevel admin

# Interface Settings
!define MUI_ABORTWARNING

# Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Languages
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"

# Installer Sections
Section "Install"
  # Set output path to the installation directory
  SetOutPath $INSTDIR
  
  # Add files - corrected path
  File /r "build\windows\x64\runner\Release\*"
  
  # Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  # Registry information for add/remove programs
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "DisplayName" "Simple Live"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "UninstallString" "\"$INSTDIR\Uninstall.exe\""
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "QuietUninstallString" "\"$INSTDIR\Uninstall.exe\" /S"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "DisplayIcon" "$INSTDIR\${APP_EXECUTABLE},0"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "Publisher" "Simple Live Team"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "DisplayVersion" "${APP_VERSION}"
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "NoModify" 1
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live" "NoRepair" 1
  
  # Create shortcut
  CreateDirectory "$SMPROGRAMS\Simple Live"
  CreateShortCut "$SMPROGRAMS\Simple Live\Simple Live.lnk" "$INSTDIR\${APP_EXECUTABLE}"
  CreateShortCut "$SMPROGRAMS\Simple Live\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  CreateShortCut "$DESKTOP\Simple Live.lnk" "$INSTDIR\${APP_EXECUTABLE}"
SectionEnd

# Uninstaller Section
Section "Uninstall"
  # Remove files
  RMDir /r "$INSTDIR\*.*"
  
  # Remove directories
  RMDir "$INSTDIR"
  
  # Remove shortcuts
  Delete "$SMPROGRAMS\Simple Live\Simple Live.lnk"
  Delete "$SMPROGRAMS\Simple Live\Uninstall.lnk"
  RMDir "$SMPROGRAMS\Simple Live"
  Delete "$DESKTOP\Simple Live.lnk"
  
  # Remove registry keys
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\Simple Live"
  DeleteRegKey HKCU "Software\Simple Live"
SectionEnd