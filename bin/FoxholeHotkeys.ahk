#singleInstance, Force
#MaxThreadsPerHotkey 2
SetWorkingDir, %A_ScriptDir%

; Mouse coords relative to the target window's CLIENT area (not its outer frame).
; Without this, the default "relative to active window" includes the title bar and
; border, so in windowed mode every posted click lands offset by that frame and
; misses - the clicks only worked because borderless/fullscreen has no frame.
CoordMode, Mouse, Client

;------------------------------------------------------------;
; Foxhole Hotkeys - GUI Version - by Tommythebold            ;
;------------------------------------------------------------;
; Default key bindings are:									 ;
; F2 - Spam Left Click at Location (holds Shift)             ;
; F3 - Hold W                                                ;
; F4 - Hold S                                                ;
; F5 - Hold Right Click                                      ;
; F6 - Hold Left Click                                       ;
; F7 - Suspend Program                                       ;
; F9 - Exit Program                                          ;
; 9  - Auto Arty Reloader                                    ;
; 0  - Auto Border Base Camping                              ;
; While Hold W is active it also spams the Open Gate key     ;
; ([Keys] Open Gate Key, default N).                         ;
; Most hotkeys work tabbed out; Auto Arty/Border Base send   ;
; to the focused window (keep Foxhole focused for those).    ;
;------------------------------------------------------------;
; If you want to manually change keybinds, use the           ;
; FoxholeHotkeysManual version in the bin folder.            ;
; https://github.com/Tommythebold/Foxhole-AutoClicker        ;
;------------------------------------------------------------;

; Each read has a default (last arg) so a missing/old KeyBindings.ini
; still works instead of leaving a blank key that would break loading.
IniRead, HoldW, KeyBindings.ini, Hotkeys, Hold W, F3
IniRead, HoldS, KeyBindings.ini, Hotkeys, Hold S, F4
IniRead, HoldLeft, KeyBindings.ini, Hotkeys, Hold Left, F7
IniRead, HoldRight, KeyBindings.ini, Hotkeys, Hold Right, F6
IniRead, SpamLeft, KeyBindings.ini, Hotkeys, Spam Left, F2
IniRead, SpamLeftBuild, KeyBindings.ini, Hotkeys, Spam Left Build, F5
IniRead, AutoArty, KeyBindings.ini, Hotkeys, Auto Arty Reload, 9
IniRead, AutoBorder, KeyBindings.ini, Hotkeys, Auto Border Base, 0
IniRead, Suspend, KeyBindings.ini, Hotkeys, Suspend, F9
IniRead, Close, KeyBindings.ini, Hotkeys, Close, F10
IniRead, OpenGateKey, KeyBindings.ini, Keys, Open Gate Key, n

; Guard each registration: one bad/blank key disables only that hotkey,
; never halts the whole script (which would kill every hotkey).
if (HoldW != "")
	Hotkey, %HoldW%, Hold_W
if (HoldS != "")
	Hotkey, %HoldS%, Hold_S
if (HoldRight != "")
	Hotkey, %HoldRight%, Hold_Right
if (HoldLeft != "")
	Hotkey, %HoldLeft%, Hold_Left
if (SpamLeft != "")
	; '*' wildcard: fire even while modifiers are held. Required because this
	; hotkey holds Left Shift down itself - without '*', the toggle-off press
	; registers as Shift+<key> and would never match to stop the loop.
	Hotkey, *%SpamLeft%, Spam_Left
if (SpamLeftBuild != "")
	Hotkey, %SpamLeftBuild%, Spam_Left_Build
if (AutoArty != "")
	Hotkey, %AutoArty%, Auto_Arty_Reload
if (AutoBorder != "")
	Hotkey, %AutoBorder%, Auto_Border_Base
if (Suspend != "")
	Hotkey, %Suspend%, Key_Suspend
if (Close != "")
	Hotkey, %Close%, Key_Close
return

;-----------------------------;
; Spam Left Click at Location ;
;-----------------------------;

Spam_Left:
MouseGetPos, xpos, ypos
T := !T
if (T) {
	; Hold Left Shift for the whole spam (for pulling full stacks) with a REAL,
	; global key event - the game reads held-Shift from the OS keyboard
	; (GetAsyncKeyState), which a window-scoped ControlSend can't drive. Because the
	; Shift is global, it does affect other programs while the spam runs (e.g. typing
	; elsewhere comes out capitalised) - that's an accepted trade-off for the pull to
	; work while tabbed out. Shift is pressed once here and NOT re-asserted, so a
	; single physical Shift tap releases it and turns the shift-hold off for the rest
	; of the run (toggle F2 off/on to get it back). Clicks are POSTED to Foxhole's
	; window, so they keep going tabbed out. MK_LBUTTON=0x1, MK_SHIFT=0x4;
	; ControlClick can't carry a modifier, so we PostMessage like "Spam Left
	; Building" does.
	Send {LShift down}
	While (T) {
		PostMessage, 0x200, 0x0004, (xpos & 0xFFFF) | (ypos << 16), , ahk_class UnrealWindow ; WM_MOUSEMOVE + Shift
		PostMessage, 0x201, 0x0005, (xpos & 0xFFFF) | (ypos << 16), , ahk_class UnrealWindow ; WM_LBUTTONDOWN + Shift
		PostMessage, 0x202, 0x0004, (xpos & 0xFFFF) | (ypos << 16), , ahk_class UnrealWindow ; WM_LBUTTONUP + Shift
		sleep, 100
	}
	Send {LShift up}
}
return

;-----------------;
; Hold Left Click ;
;-----------------;

Hold_Left:
MouseGetPos, xpos, ypos
T := !T
While (T) {
	ControlClick, X%xpos% Y%ypos%, ahk_class UnrealWindow, , Left, 1, D
}
ControlClick, X%xpos% Y%ypos%, ahk_class UnrealWindow, , Left, 1, u
return

;------------------------------;
; Spam Left Click for Building ;
;------------------------------;
Spam_Left_Build:
T := !T
While (T) {
	PostMessage, 0x0200, 0, cX&0xFFFF | cY<<16,, ahk_class UnrealWindow ; WM_MOVEMOUSE
	PostMessage, 0x201, 0, cX&0xFFFF | cY<<16,, ahk_class UnrealWindow ; WM_LBUTTONDOWN  
  	PostMessage, 0x202, 0, cX&0xFFFF | cY<<16,, ahk_class UnrealWindow ; WM_LBUTTONUP  
	sleep, 100
}
return

;------------------;
; Hold Right Click ;
;------------------;

Hold_Right:
MouseGetPos, xpos, ypos
T := !T
While (T) {
	ControlClick, X%xpos% Y%ypos%, ahk_class UnrealWindow, , Right, 1, D
}
ControlClick, X%xpos% Y%ypos%, ahk_class UnrealWindow, , Right, 1, u
return

;----------------------------;
; Hold W (+ spam Open Gate)   ;
;----------------------------;

Hold_W:
toggle := !toggle
ControlSend,,{w down}, ahk_class UnrealWindow
if (toggle) {
	SetTimer, PressW, 1000
	SetTimer, SpamGate, 100
}	else {
	SetTimer, PressW, Off
	SetTimer, SpamGate, Off
	ControlSend,,{w up}, ahk_class UnrealWindow
}
return

PressW:
ControlSend,,{w down}, ahk_class UnrealWindow
return

SpamGate:
ControlSend,,{%OpenGateKey%}, ahk_class UnrealWindow
return

;--------;
; Hold S ;
;--------;

Hold_S:
toggle := !toggle
ControlSend,,{s down}, ahk_class UnrealWindow
if (toggle) {
	SetTimer, PressS, 1000
}	else {
	SetTimer, PressS, Off
	ControlSend,,{s up}, ahk_class UnrealWindow
}
return

PressS:
ControlSend,,{s down}, ahk_class UnrealWindow
return

;-----------------;
; Suspend Program ;
;-----------------;

Key_Suspend:
Suspend, Permit   ; keep this hotkey alive while suspended so it can un-suspend
; Actually STOP everything: reset every toggle, kill the Hold timers, and release
; any held keys. Plain Suspend only blocks future presses - it never interrupts a
; loop already running, so the spamming/holding would otherwise continue.
T := false
toggle := false
artyToggle := false
borderToggle := false
SetTimer, PressW, Off
SetTimer, SpamGate, Off
SetTimer, PressS, Off
ControlSend,,{w up}, ahk_class UnrealWindow
ControlSend,,{s up}, ahk_class UnrealWindow
Send {LShift up}
Suspend, Toggle
return

;---------------;
; Close Program ;
;---------------;

Key_Close:
Suspend, Permit   ; let Close work even while the hotkeys are suspended
ExitApp
return

;---------------------;
; Auto Arty Reloader  ;
;---------------------;
; Sends to the focused window (keep Foxhole focused).

Auto_Arty_Reload:
artyToggle := !artyToggle
While (artyToggle) {
	Send, {r down}
	Send, {r up}
	Click, Left
	sleep, 200
}
return

;--------------------------;
; Auto Border Base Camping ;
;--------------------------;
; Sends to the focused window (keep Foxhole focused).

Auto_Border_Base:
borderToggle := !borderToggle
While (borderToggle) {
	Send, {E down}
	Send, {E up}
	sleep, 20
}
return
