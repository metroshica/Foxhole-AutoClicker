#singleInstance, Force
#MaxThreadsPerHotkey 2
DetectHiddenWindows,on
SetWorkingDir, %A_ScriptDir%

IniRead, Suspend, bin\KeyBindings.ini, Hotkeys, Suspend
IniRead, Close, bin\KeyBindings.ini, Hotkeys, Close

Menu, Tray, Icon, bin\icon.ico  ; logo for tray + window title-bar icon
; Fixed 210px-wide client so everything can be centered to it:
;   groupboxes x20 w170 (20px margin each side), buttons x30 w150 (centered),
;   logo x22 w165 (centered), title spans full width with Center.
Gui, New
Gui, -MaximizeBox
Gui, Margin, 20, 10
Gui, Font, s11 Bold, Verdana
Gui, Add, Picture, x22 y10 w165 h165, bin\iconLarge.png
Gui, Add, Text, x0 y182 w210 Center, Foxhole AutoClicker
Gui, Font, s8 norm, Verdana
Gui, Add, Text, x0 y205 w210 Center c808080, v2.0
Gui, Add, GroupBox, x20 y224 w170 h120, Controls
Gui, Add, Button, x30 y246 w150 h26 gRunHotkey, Start Hotkeys
Gui, Add, Button, x30 y+8 w150 h26 gSuspendHotkey, Suspend Hotkeys - %Suspend%
Gui, Add, Button, x30 y+8 w150 h26 gExitHotkey, Close Hotkeys - %Close%
Gui, Add, GroupBox, x20 y354 w170 h88, KeyBinds
Gui, Add, Button, x30 y376 w150 h26 gChangeKeybindGUI, Change Keybinds
Gui, Add, Button, x30 y+8 w150 h26 gviewKeybinds, Open Config File
Gui, Add, CheckBox, x30 y+16 gontop, Window Always on Top?
Gui, Add, Link, x30 y+8, <a href="https://github.com/Tommythebold/Foxhole-AutoClicker">GitHub</a>
Gui, Show, w210
return

ChangeKeybindGUI:
{
	; read current binds so each row can show its current key
	IniRead, curHoldW, bin\KeyBindings.ini, Hotkeys, Hold W, F3
	IniRead, curGate, bin\KeyBindings.ini, Keys, Open Gate Key, n
	IniRead, curHoldS, bin\KeyBindings.ini, Hotkeys, Hold S, F4
	IniRead, curHoldRight, bin\KeyBindings.ini, Hotkeys, Hold Right, F6
	IniRead, curHoldLeft, bin\KeyBindings.ini, Hotkeys, Hold Left, F7
	IniRead, curSpamLeft, bin\KeyBindings.ini, Hotkeys, Spam Left, F2
	IniRead, curSpamBuild, bin\KeyBindings.ini, Hotkeys, Spam Left Build, F5
	IniRead, curArty, bin\KeyBindings.ini, Hotkeys, Auto Arty Reload, 9
	IniRead, curBorder, bin\KeyBindings.ini, Hotkeys, Auto Border Base, 0
	IniRead, curSuspend, bin\KeyBindings.ini, Hotkeys, Suspend, F9
	IniRead, curClose, bin\KeyBindings.ini, Hotkeys, Close, F10

	; Fixed 310px-wide client, centered like the main window. Each row is an
	; action label (Verdana) plus a monospace "keycap" button showing the current
	; key - click it to rebind. Labels are added first, then the keycap buttons,
	; so the two fonts don't have to be toggled on every row.
	Gui, Keys:New
	Gui, Keys:-MaximizeBox
	Gui, Keys:Margin, 20, 10
	Gui, Keys:Font, s11 Bold, Verdana
	Gui, Keys:Add, Picture, x72 y10 w165 h165, bin\iconLarge.png
	Gui, Keys:Add, Text, x0 y182 w310 Center, Change Keybinds
	Gui, Keys:Font, s8 norm, Verdana
	Gui, Keys:Add, Text, x0 y206 w310 Center c808080, Click a bind, then press a key. Esc cancels.
	Gui, Keys:Add, GroupBox, x20 y228 w270 h356, Keybinds

	; action labels
	Gui, Keys:Add, Text, x32 y250 w168 h24 +0x200, Hold W
	Gui, Keys:Add, Text, x32 y280 w168 h24 +0x200, Open Gate (while Hold W)
	Gui, Keys:Add, Text, x32 y310 w168 h24 +0x200, Hold S
	Gui, Keys:Add, Text, x32 y340 w168 h24 +0x200, Hold Right Click
	Gui, Keys:Add, Text, x32 y370 w168 h24 +0x200, Hold Left Click
	Gui, Keys:Add, Text, x32 y400 w168 h24 +0x200, Spam Left + Shift
	Gui, Keys:Add, Text, x32 y430 w168 h24 +0x200, Spam Left Building
	Gui, Keys:Add, Text, x32 y460 w168 h24 +0x200, Auto Arty Reloader
	Gui, Keys:Add, Text, x32 y490 w168 h24 +0x200, Auto Border Base Camping
	Gui, Keys:Add, Text, x32 y520 w168 h24 +0x200, Suspend Hotkeys
	Gui, Keys:Add, Text, x32 y550 w168 h24 +0x200, Close Hotkeys

	; keycap buttons (monospace) - click to rebind
	Gui, Keys:Font, s10 Bold, Consolas
	Gui, Keys:Add, Button, x205 y250 w75 h24 vbindW gSetKeyW, %curHoldW%
	Gui, Keys:Add, Button, x205 y280 w75 h24 vbindGate gSetOpenGateKey, %curGate%
	Gui, Keys:Add, Button, x205 y310 w75 h24 vbindS gSetKeyS, %curHoldS%
	Gui, Keys:Add, Button, x205 y340 w75 h24 vbindRight gSetKeyRight, %curHoldRight%
	Gui, Keys:Add, Button, x205 y370 w75 h24 vbindLeft gSetKeyLeft, %curHoldLeft%
	Gui, Keys:Add, Button, x205 y400 w75 h24 vbindSpamLeft gSetKeySpamLeft, %curSpamLeft%
	Gui, Keys:Add, Button, x205 y430 w75 h24 vbindSpamBuild gSetKeySpamLeftBuild, %curSpamBuild%
	Gui, Keys:Add, Button, x205 y460 w75 h24 vbindArty gSetAutoArty, %curArty%
	Gui, Keys:Add, Button, x205 y490 w75 h24 vbindBorder gSetAutoBorder, %curBorder%
	Gui, Keys:Add, Button, x205 y520 w75 h24 vbindSuspend gSetKeySuspend, %curSuspend%
	Gui, Keys:Add, Button, x205 y550 w75 h24 vbindClose gSetKeyClose, %curClose%

	Gui, Keys:Font, s8 norm, Verdana
	Gui, Keys:Add, Button, x25 y600 w120 h28 gResetDefaults, Reset Defaults
	Gui, Keys:Add, Button, x165 y600 w120 h28 gKeysDone, Done
	Gui, Keys:Show, w310, Change Keybinds
}
return

ResetDefaults:
{
	MsgBox, 0x4, Reset Keybinds, Reset all keybinds to their defaults?
	IfMsgBox, No
		return
	IniWrite, F3, bin\KeyBindings.ini, Hotkeys, Hold W
	IniWrite, n, bin\KeyBindings.ini, Keys, Open Gate Key
	IniWrite, F4, bin\KeyBindings.ini, Hotkeys, Hold S
	IniWrite, F6, bin\KeyBindings.ini, Hotkeys, Hold Right
	IniWrite, F7, bin\KeyBindings.ini, Hotkeys, Hold Left
	IniWrite, F2, bin\KeyBindings.ini, Hotkeys, Spam Left
	IniWrite, F5, bin\KeyBindings.ini, Hotkeys, Spam Left Build
	IniWrite, 9, bin\KeyBindings.ini, Hotkeys, Auto Arty Reload
	IniWrite, 0, bin\KeyBindings.ini, Hotkeys, Auto Border Base
	IniWrite, F9, bin\KeyBindings.ini, Hotkeys, Suspend
	IniWrite, F10, bin\KeyBindings.ini, Hotkeys, Close
	GuiControl, Keys:, bindW, F3
	GuiControl, Keys:, bindGate, n
	GuiControl, Keys:, bindS, F4
	GuiControl, Keys:, bindRight, F6
	GuiControl, Keys:, bindLeft, F7
	GuiControl, Keys:, bindSpamLeft, F2
	GuiControl, Keys:, bindSpamBuild, F5
	GuiControl, Keys:, bindArty, 9
	GuiControl, Keys:, bindBorder, 0
	GuiControl, Keys:, bindSuspend, F9
	GuiControl, Keys:, bindClose, F10
}
return

KeysDone:
KeysGuiClose:
{
	Gui, Keys:Destroy
}
return

SetKeyW:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Hold W
		GuiControl, Keys:, bindW, %var1%
	}
}
return

SetOpenGateKey:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Keys, Open Gate Key
		GuiControl, Keys:, bindGate, %var1%
	}
}
return

SetAutoArty:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Auto Arty Reload
		GuiControl, Keys:, bindArty, %var1%
	}
}
return

SetAutoBorder:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Auto Border Base
		GuiControl, Keys:, bindBorder, %var1%
	}
}
return

SetKeyS:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Hold S
		GuiControl, Keys:, bindS, %var1%
	}
}
return

SetKeyRight:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Hold Right
		GuiControl, Keys:, bindRight, %var1%
	}
}
return

SetKeyLeft:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Hold Left
		GuiControl, Keys:, bindLeft, %var1%
	}
}
return

SetKeySpamLeft:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Spam Left
		GuiControl, Keys:, bindSpamLeft, %var1%
	}
}
return

SetKeySpamLeftBuild:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Spam Left Build
		GuiControl, Keys:, bindSpamBuild, %var1%
	}
}
return

SetKeySuspend:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Suspend
		GuiControl, Keys:, bindSuspend, %var1%
	}
}
return

SetKeyClose:
{
	var1 := KeyWaitCombo()
	if (var1 != "")
	{
		IniWrite, %var1%, bin\KeyBindings.ini, Hotkeys, Close
		GuiControl, Keys:, bindClose, %var1%
	}
}
return

KeyWaitCombo(Options:="")
{
	ToolTip, Press a Key
	SetTimer, RemoveToolTip, -5000

    ih := InputHook(Options)
    if !InStr(Options, "V")
        ih.VisibleNonText := false
    ih.KeyOpt("{All}", "E")
    ih.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-E")
    ih.Start()
    ErrorLevel := ih.Wait()
	var := ih.EndMods . ih.EndKey
	if (ih.EndKey = "Escape")   ; Esc cancels the rebind without changing anything
	{
		ToolTip
		return ""
	}
	ToolTip, Set to %var%
	SetTimer, RemoveToolTip, -2000
	return var
}

RemoveToolTip:
{
	ToolTip
	return
}
return

RunHotkey:
{
	Run, bin\FoxholeHotkeys.ahk
	ToolTip, Hotkeys started
	SetTimer, RemoveToolTip, -1200
}
return

SuspendHotKey:
{
	IniRead, Suspend, bin\KeyBindings.ini, Hotkeys, Suspend
	Send {%Suspend%}
	ToolTip, Suspend toggled
	SetTimer, RemoveToolTip, -1200
}
return

ExitHotkey:
{
	IniRead, Close, bin\KeyBindings.ini, Hotkeys, Close
	IniRead, Suspend, bin\KeyBindings.ini, Hotkeys, Suspend
	Send {%Close%}
	Send {%Suspend%}
	Send {%Close%}
	ToolTip, Hotkeys closed
	SetTimer, RemoveToolTip, -1200
}
return

viewKeybinds:
{
	Run, bin\KeyBindings.ini
}
return

ontop:
{
	T := !T
	If T
		Gui +AlwaysOnTop
	else
		Gui -AlwaysOnTop
}
return

GuiClose:
ExitApp