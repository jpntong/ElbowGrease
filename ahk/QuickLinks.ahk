;
; This code is an adaptation of QuickLinks.ahk, by Jack Dunning.
; http://www.computoredge.com/AutoHotkey/AutoHotkey_Quicklinks_Menu_App.html
; Update 2019-10-24:
;- Added name of menu as variable 
;- Changed functions to V2 compatible
;- Submenu's with the same name are allowed now

#NoEnv
#SingleInstance, Force

Menu, Tray, Icon, shell32.dll, 290

QL_CreateMenu()

^!+F1:: ;black key col1,row5
QL_Show()
return

QL_CreateMenu(QL_Link_Dir := "Links") { ; Just run it one time at the start.
	If !InStr(QL_Link_Dir, "\"){
		QL_Link_Dir := A_ScriptDir "\" QL_Link_Dir 
	}
	
	SplitPath, QL_Link_Dir,QL_Menu
	
	If !FileExist(QL_Link_Dir){
		FileCreateDir, %QL_Link_Dir%
	}
	FileCreateShortcut, %QL_Link_Dir%, %QL_Link_Dir%\%QL_Menu%.lnk
	
	Loop, %QL_Link_Dir%\*.*, 1 , 1
	{	
		if InStr(A_LoopFileAttrib, "H") or InStr(A_LoopFileAttrib, "R"),  or InStr(A_LoopFileAttrib, "S") ;Skip any file that is H, R, or S (System).
			continue
		
		Folder1  := RegExReplace(A_Loopfilefullpath, "(.*\\[^\\]*)\\([^\\]*)\\([^\\]*)", "$2")
		Folder1Menu  := QL_Menu StrReplace(StrReplace(RegExReplace(A_Loopfilefullpath, "(.*\\[^\\]*\\[^\\]*)\\([^\\]*)", "$1"), QL_Link_Dir), "\")
		Folder2Menu  := QL_Menu StrReplace(StrReplace(RegExReplace(A_Loopfilefullpath, "(.*\\[^\\]*)\\([^\\]*)\\([^\\]*)", "$1"), QL_Link_Dir), "\")
		
		BoundRun := Func("Run").Bind(A_Loopfilefullpath)
		Linkname := StrReplace(A_LoopFileName, ".lnk")
		
		Menu, %Folder1Menu%, Add, %Linkname% , %BoundRun%
		Icon_Add(Folder1Menu,Linkname,A_LoopFileFullPath) ; icon
		Menu , %Folder2Menu%, Add, %Folder1%, :%Folder1Menu% ; Create submenu
		Menu , %Folder2Menu% , Icon , %Folder1% , C:\Windows\syswow64\SHELL32.dll , 5 ; icon for folder
	}
	return
}

QL_Show(Link_Name:= "Links") {
	Menu, %Link_Name%, Show
}

Run( a) {
	run, %a%
}

Icon_Add(menuitem,submenu,LoopFileFullPath) ; add icon based on extention or name
{	FileGetShortcut,%A_LoopFileFullPath% ,File
Extension  := RegExReplace(File, "(.*)(\..*)", "$2")
Icon_nr = 0
If (Extension = ".ahk")
	Menu, %menuitem%, Icon, %submenu%, autohotkey.exe,2
If (Extension = ".jpg")
	Menu, %menuitem%, Icon, %submenu%, %A_Windir%\system32\SHELL32.dll, 140,
else If (Extension = ".pdf")
	Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\PDF.ico
else If InStr(Extension, "\") or InStr(Extension, "-")
	Menu, %menuitem%, Icon, %submenu%, C:\Windows\syswow64\SHELL32.dll , 5
else if (Extension = ".xls")
	Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\xlicons.exe, 0
else if (Extension = ".doc")
	Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\wordicon.exe, 0
else if InStr(Extension, ".website")
	Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\ielowutil.exe, 0
else if (Extension = ".txt")
	Menu, %menuitem%, Icon, %submenu%, C:\Windows\syswow64\SHELL32.dll , 1
Return
}