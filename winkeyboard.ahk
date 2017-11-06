;=========================================================================
; AUTOHOTKEY quick reference
;=========================================================================
; $ = hook, prevent circular reference?
; ! = ALT
; ^ = CTRL
; # = windows key

;-------------------------------------------------------------------------
; Notes:
;-------------------------------------------------------------------------
; In Windows, ALT key is rarely used, but it is also one of the most useful
; keys.  Also thumb is the strongest finger. Pinkie is the weakest.

;-------------------------------------------------------------------------
; Installation: 
; SharpKeys: 
;-------------------------------------------------------------------------
; remap Left Alt to Left Windows
; remap LEFT WIN to Right CTRL?
;   so that Win+Ctrl combo is still possible
;   but there aren't many Alt+Win combo
; NOTE: possibly map to RIGHT WIN/ALT instead?
; to avoid collision with autohotkey scripts
; OLD: Remap Left Alt to Right Control!!!
;   remap CapsLock to Left Control (Optional)
;

;=========================================================================
; Recommended system-wide setting
;=========================================================================
SendMode Input
#NoEnv
#SingleInstance Force ; SingleInstance makes the script automatically reload?.
; make sure only one instance of this script is running!!!

;-------------------------------------------------------------------------
;[PAUSE/BREAK]
; Pressing Pause/Break will toggle AHK script; Useful when you want to quickly switch off AHK, esp when you want to share the keyboard with someone else
;-------------------------------------------------------------------------
Pause::Suspend


;-------------------------------------------------------------------------
; swap Alt with Win
; NOTE: doesn't seem to trigger win key mapping
;-------------------------------------------------------------------------
;RAlt::RWin
; 

;=========================================================================
; WINDOWS-Specific
;=========================================================================
;-------------------------------------------------------------------------
; ALT Tab
;-------------------------------------------------------------------------
; Reason we can't map All Alt to CTRL is that CTRL-C,V,X,A,Z is special and 
; they can mess up terminal.  We want to actually copy and paste when pressing 
; ALT vs the real CTRL key.
; Possible Solution: 
; LCtrl & Tab - cannot use Copy/Paste if using left control
; LCtrl & Tab:: AltTab -- this doesn't work in Admin mode in PS, CMD.exe
; Use RCtrl so that LCtrl is used for LCtrl-C for Stop, and RCtrl-C for copy
; if using WInkey, disable this
;RCtrl & tab:: AltTab

; using WIndows key isntead
LWin & tab:: AltTab

; TODO: not sure whether to use LAlt or RAlt???
; DOES NOT WORK!!!
; Right Alt
; VistaSwitcher can do this.  
; $>!`::Send ^{tab} 

;-------------------------------------------------------------------------
; Copy/Cut/Paste using Win key
; 
; NOTE: how to use Win key exclusively? don't know
;      this works with Shift-Win, Ctrl-Win, etc...
;       I want Win only. Not using wildcard (*)
;       Perhaps create another key 
;       But strangely, Win-A is exclusive, not wildcard 
;-------------------------------------------------------------------------
; WIN+C -> CTRL+C
#a::^a    ; replace action center
#c::^c     ; replaces cortana 
#v::^v      ; replaces notification
#x::^x     ; replaces quick-link-menu
#z::^z     ; replaces full-screen menu
#s::^s     ; replaces search
#n::^n     ; replaces (undefined)
#i::^i     ; replaces setting
#b::^b     ; replaces set focus on notification area
#f::^f      ; replaces Feedback Hub
#o::^o      ; replaces Lock-orientation switch 
#t::^t      ; replaces Cycle through apps on taskbar
#w::^w      ; replaces (undefined)
#y::^y      ;REDO in mac, replaces (switch mixed reality)
#m::WinMinimize,a ; Mac minimize this window; replaces Minimize ALl WIndows

; #u::^u     ; replaces ease of access center
            ; looks like #u cannot be remapped. 
; #j, #k set aside for virtual desktop, see below

;-------------------------------------------------------------------------
; CMD+F = F3, Find and Find Next/prev
;-------------------------------------------------------------------------
; [CTRL]+[g]
$>^g::Send {F3}
; WinG doesn't work (cannot be mapped?)
#g::Send {F3}

; [CTRL]+[G]
$>^+G::Send {Shift Down}{F3}{Shift Up}
#+G::Send {F3}

;-------------------------------------------------------------------------
; Quit, [CTRL]+[q]
;-------------------------------------------------------------------------
; Alt+F4  OR Alt+Space C
;$!q::Send {Alt Down}{F4}{Alt Up} ; doesn't work see {below}'
$>^q::Send !{f4}
#q::Send !{f4}

; this could also be Ctrl+F4, but not sure which one is more compatible

;-------------------------------------------------------------------------
; Ctrl+arrow
;-------------------------------------------------------------------------
; Alt+ uparrow => Ctrl+Home / go to top of document
; Alt+ downarrow => Ctrl+End / go to bottom of document
; Alt up/down is useful in Visual Code, as it moves lines up/down
; so use Right Alt to do this, since it is still preserved on RAlt
RCtrl & up::Send ^{home}  
RCtrl & down::Send ^{end} 
>^left::Send {home} 

; RCtrl & left::Send {home} ; Don't use this as it also captures Windows key
;RCtrl & right::Send {end} 
; Don't use this as it also captures Windows key
>^right::Send {end} 

; Win-J, WIn-K is Home/End
#j::Send ^{home} 
#k::Send ^{end} 

;===========================================================================
; Virtual Desktop deskspace - 
; default Win: LCtrl+Win+arrow = switch desk space
; I want Mac style, where it is CMD+LAlt+Arrow
; mimic Mac's desktop move. Win + RCtrl + left = same as Win+LCtrl+left
; Mac = CMd+Alt+left.   Win = WIn+Ctrl+left
;
; * NOTE: not needed on window once ctrl was mapped to ALT
;           since by default, Ctrl+Win+arrow is switch desk space
; * It was hard to remap ctrl+tab, and so using vim-style
; * Win+] = next desktop, but it was interfering with Win },{
; * win+[ = prev desktop
; * was using Win+j/k but it felt it could be app-specific
;===========================================================================
;use menu key to open taskview
AppsKey::#Tab
; Ctrl+Tab
; move through desktop spaces
;RCtrl & Tab::send #A

; weird, works with right ctrl, but not left
^#]::^#Right
^#[::^#Left

;===========================================================================
; Remap Caps Lock in Windows (escape *and* control) https://superuser.com/a/581988
;===========================================================================
; uses hardware switch 
; but capslock (no matter where it is) should be ctrl
; in case of Leopold keyboard, it switches Capslock with Ctrl
;   but I want new capslock (CTRL) to act as ctrl, still
; Capslock dual function - original , but not workin gwell
; *CapsLock::
;     Send {Blind}{Ctrl Down}
;     cDown := A_TickCount
; Return

; *CapsLock up::
;     If ((A_TickCount-cDown)<200)  ; Modify press time as needed (milliseconds)
;         Send {Blind}{Ctrl Up}{Esc}
;     Else
;         Send {Blind}{Ctrl Up}
; Return

;
;===========================================================================
; DUal function - CTRL as both ESC and CTRL
;===========================================================================
; LCtrl - dual function - original, but not working well
*LCtrl::
    Send {Blind}{LCtrl Down}
    cDown := A_TickCount
Return

*LCtrl up::
    If ((A_TickCount-cDown)<200)  ; Modify press time as needed (milliseconds)
        Send {Blind}{LCtrl Up}{Esc}
    Else
        Send {Blind}{LCtrl Up}
Return

; also for Non-programmable keyboard, Win needs to set Capslock to CTRL
; in registry. 

; double-function key - disabled for now, using lctrl instead
; *CapsLock::
;     Send {Blind}{Ctrl Down}
;     cDown := A_TickCount
; Return

; *CapsLock up::
;     If ((A_TickCount-cDown)<200)  ; Modify press time as needed (milliseconds)
;         Send {Blind}{Ctrl Up}{Esc}
;     Else
;         Send {Blind}{Ctrl Up}
; Return

;Assumption: 
; CAPSLOCK has been mapped physically to CTRL, either with keyboard switch
; or with registry hack on windows

; switch capslock with control just in case it didn't
; only because Leopold kb is switched
; was using L/RCtrl instead of Ctrl to avoid loops (from LCtrl -double function)
Capslock::Ctrl

; My try - it works for some reason, but only on hardware CTRL (unmapped)
;LCtrl::Send {esc}

;===========================================================================
; Shift only as ( )
; NOTE: on remote deskotp, it doesn't work, printing 9 and 0 
;===========================================================================

; https://autohotkey.com/board/topic/98742-remapping-shift-key/
; ~LShift::
; 	KeyWait, LShift
; 	If (A_TimeSinceThisHotkey < 200 and A_PriorKey = "LShift") {
; 		Send, (
; 	}
; return
;
; ~RShift::
; 	KeyWait, RShift
; 	If (A_TimeSinceThisHotkey < 200 and A_PriorKey = "RShift") {
; 		Send, )
; 	}
; return
;
;===========================================================================
; Alt-backtick , just like Mac
; https://superuser.com/a/768060
;===========================================================================
;!`::    ; Next window
;^ESC::    ; Next window ; For Leopold keyboard only (ESC was mapped to ~)
#`::    ; Next window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinSet, Bottom,, A
WinActivate, ahk_class %ActiveClass%
return

;^+ESC::    ; Last window; Leopold keyboard
#+`::    ; 
WinGetClass, ActiveClass, A
WinActivateBottom, ahk_class %ActiveClass%
return

;===========================================================================
; Function / media keys
;===========================================================================
;RAlt & F7::SendInput {Media_Prev}
;RAlt & F8::SendInput {Media_Play_Pause}
;RAlt & F9::SendInput {Media_Next}
;; might interfere with Visual Studio
;F10::SendInput {Volume_Mute}
;F11::SendInput {Volume_Down}
;F12::SendInput {Volume_Up}

;===========================================================================
; App-specific
;===========================================================================
; TAB on Chrome tab, and others... doesn't work on all
; TODO: make it app-specific...
; [CTRL]+[]] and [CTRL]+[[]
; Mac: Cmd+Shift+] or [ go to next/prev tabs
; Win: Ctrl+Tab, Ctrl+Shift+Tab
; Key difference
#}::Send ^{Tab}
#{::Send ^+{Tab}

; If using ctrl instead
; ^+]::Send ^{Tab}
; ^+[::Send ^+{Tab}
^}::Send ^{Tab}
^{::Send ^+{Tab}

;SetTitleMatchMode 2 ;- Mode 2 is window title substring.
;#IfWinActive, OneNote ; Only apply this script to onenote.

;-------------------------------------------------------------------------
; Google Chrome
;-------------------------------------------------------------------------
#IfWinActive, ahk_class Chrome_WidgetWin_1
; Show Web Developer Tools with cmd + alt + i
#!i::Send {F12}
; Show source code with cmd + alt + u
#^u::Send ^u


;-------------------------------------------------------------------------
; Vim, GVim
;-------------------------------------------------------------------------
#IfWinActive ahk_class Vim
$>^c:: Send {Ctrl Down}{Insert}{Ctrl Up}
; better paste, works with terminal, but doesn't work with Explorer
$>^v::Send {Shift down}{Insert}{Shift Up} 
$>^x::Send {Shift Down}{Del}{Shift Up}
;#space::MsgBox "Pressed Win+Space in VIM"

;-------------------------------------------------------------------------
; Mintty, Cygwin, 
;-------------------------------------------------------------------------
#IfWinActive ahk_class mintty
$>^c:: Send {Ctrl Down}{Insert}{Ctrl Up}
; better paste, works with terminal, but doesn't work with Explorer
$>^v::Send {Shift down}{Insert}{Shift Up} 
$>^x::Send {Shift Down}{Del}{Shift Up}
;#space::MsgBox "Pressed Win+Space in Mintty"
  
; Everything Search App
; Currently hotkey not needed, and using Wox (front-end to Everything) instead
; hotkey for Everything (currently set to Win+Shift+F)
; RCtrl & space::Send #F

#IfWinActive
; Nothing else below


