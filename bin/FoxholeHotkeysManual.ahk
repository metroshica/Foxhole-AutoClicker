#singleInstance, Force
#MaxThreadsPerHotkey 2

;------------------------------------------------------------;
; Foxhole Hotkeys - Manual Version - by Tommythebold         ;
;------------------------------------------------------------;
; A version with GUI for setting keybinds is available at    ;
; https://github.com/Tommythebold/Foxhole-AutoClicker        ;
;------------------------------------------------------------;
; Default key bindings are:									 ;
; F2 - Spam Left Click at Location (holds Shift)             ;
; F3 - Hold W (also spams Open Gate key; edit it in F3 sec.) ;
; 9  - Auto Arty Reloader                                    ;
; 0  - Auto Border Base Camping                              ;
; F4 - Hold S                                                ;
; F5 - Hold Right Click                                      ;
; F6 - Hold Left Click                                       ;
; F7 - Suspend Program                                       ;
; F9 - Exit Program                                          ;
; All hotkeys work while tabbed out.                         ;
;------------------------------------------------------------;
; To change keybindings, edit the value before the "::".     ;
; A list of keys and modifiers can be found here:            ;
; https://www.autohotkey.com/docs/v1/lib/Send.htm#Parameters ;
; ^ = Control, + = Shift, ! = Alt, etc.                      ;
;------------------------------------------------------------;

;-----------------------------;
; Spam Left Click at Location ;
;-----------------------------;

; '*' wildcard: fire even while modifiers are held. Required because this
; hotkey holds Left Shift down itself - without '*', the toggle-off press
; registers as Shift+F2 and would never match to stop the loop.
*F2::
MouseGetPos, xpos, ypos
T := !T
if (T) {
	; Hold Left Shift with a REAL key event (SendInput) for the whole loop -
	; the game reads held-modifier state from the OS keyboard (GetAsyncKeyState),
	; which a posted ControlSend message does NOT update. Foxhole must be focused
	; for the Shift hold to register. Also set the MK_SHIFT bit on each click.
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

F6::
MouseGetPos, xpos, ypos
T := !T
While (T) {
	ControlClick, X%xpos% Y%ypos%, ahk_class UnrealWindow, , Left, 1, D
}
ControlClick, X%xpos% Y%ypos%, ahk_class UnrealWindow, , Left, 1, u
return

;------------------;
; Hold Right Click ;
;------------------;

F5::
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
; While W is held this also spams the Open Gate key.
; Change the "n" in SpamGate below to whatever you bound Open Gate to in-game.

F3::
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
ControlSend,,{n}, ahk_class UnrealWindow
return

;--------;
; Hold S ;
;--------;

F4::
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

;---------------------;
; Auto Arty Reloader  ;
;---------------------;
; Sends to the focused window (keep Foxhole focused).

9::
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

0::
borderToggle := !borderToggle
While (borderToggle) {
	Send, {E down}
	Send, {E up}
	sleep, 60
}
return

;-----------------;
; Suspend Program ;
;-----------------;

F7::Suspend

;---------------;
; Close Program ;
;---------------;

F9::ExitApp
