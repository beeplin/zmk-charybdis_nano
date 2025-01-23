#Requires AutoHotkey v2.0
#SingleInstance Force
; #UseHook true

get_modifiers() {
    prefix := ""
    if (GetKeyState("LControl", "P") || GetKeyState("RControl", "P"))
        prefix := prefix "^"
    if (GetKeyState("LShift", "P") || GetKeyState("RShift", "P"))
        prefix := prefix "+"
    if ((GetKeyState("LAlt", "P") || GetKeyState("RAlt", "P")) && (GetKeyState("q", "P") || GetKeyState("[", "P")))
        prefix := prefix "!"
    if (GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
        prefix := prefix "#"
    return prefix
}

prefixes := {}

hold_tap_down(hold, tap) {
    Send "{%hold% Down}"
    global prefixes
    prefixes.%tap% := get_modifiers()
}

hold_tap_up(hold, tap, physical) {
    Send "{%hold% Up}"
    global prefixes
    if (A_PriorKey = physical) {
        if (A_TimeSincePriorHotkey < 1000)
            Suspend "1"
        Send prefixes.%tap% "{%tap%}"
        Suspend "0"
        prefixes.%tap% := ""
    }
}

; capslock -> ctrl & esc
SetCapsLockState 'AlwaysOff'
prefix_for_esc := ""
*CapsLock:: {
    Send "{LCtrl Down}"
    global prefix_for_esc
    prefix_for_esc := get_modifiers()
}
*CapsLock Up:: {
    Send "{LCtrl Up}"
    global prefix_for_esc
    if (A_PriorKey = "CapsLock") {
        if (A_TimeSincePriorHotkey < 1000)
            Suspend "1"
        Send prefix_for_esc "{Esc}"
        Suspend "0"
        prefix_for_esc := ""
    }
}

; enter -> ctrl & enter
prefix_for_enter := ""
*Enter:: {
    Send "{RCtrl Down}"
    global prefix_for_enter
    prefix_for_enter := get_modifiers()
}
*Enter Up:: {
    Send "{RCtrl Up}"
    global prefix_for_enter
    if (A_PriorKey = "Enter") {
        if (A_TimeSincePriorHotkey < 1000)
            Suspend "1"
        Send prefix_for_enter "{Enter}"
        Suspend "0"
        prefix_for_enter := ""
    }
}
; wide qwerty
y::\
u::y
i::u
o::i
p::o
[::p
]::[
\::]
h::'
j::h
k::j
l::k
`;::l
'::`;
n::RShift
m::n
,::m
.::,
/::.
RShift::/

; layer 2 - edit nav num
Space::Space
Space & q::LAlt
Space & w::BackSpace
Space & e::Up
Space & r::Delete
Space & t::PgUp
Space & y:: return
Space & u::AppsKey
Space & i::7
Space & o::8
Space & p::9
Space & [::LAlt
Space & a::Escape
Space & s::Left
Space & d::Down
Space & f::Right
Space & g::Tab
Space & h:: return
Space & j::CapsLock
Space & k::4
Space & l::5
Space & `;::6
Space & '::0
Space & Enter::RControl
Space & z::Insert
Space & x::Home
Space & c::End
Space & v::Enter
Space & b::PgDn
Space & n:: return
Space & m::CapsLock
Space & ,::1
Space & .::2
Space & /::3
Space & RShift::RShift

; layer 3 - symbol
RAlt:: return
#HotIf (GetKeyState("RAlt", "P"))
q::!
w::@
e::#
r::$
t::%
y:: return
u::^
i::&
o::*
p::-
[::=
a::`
s::-
d::=
f::`{
g::}
h:: return
j::)
k::(
l::'
`;::"
':::
Enter::RControl
z::~
x::\
c::|
v::[
b::]
n:: return
m::+
,::_
.::<
/::>
RShift::?
#HotIf

; ; layer 3 - symbol with rshift
; >+q::!
; >+w::@
; >+e::#
; >+r::$
; >+t::%
; >+y:: return
; >+u::^
; >+i::&
; >+o::*
; >+p::-
; >+[::=
; >+a::`
; >+s::-
; >+d::=
; >+f::`{
; >+g::}
; >+h:: return
; >+j::)
; >+k::(
; >+l::'
; >+`;::"
; >+':::
; >+Enter::RControl
; >+z::~
; >+x::\
; >+c::|
; >+v::[
; >+b::]
; >+n:: return
; >+m::+
; >+,::_
; >+.::<
; >+/::>

; layer 4 - func media
LAlt:: return
#HotIf (GetKeyState("LAlt", "P"))
q::LAlt
w::F9
e::F8
r::F7
t::F12
y:: return
u:: return
i::Volume_Mute
o::Volume_Down
p::Volume_Up
[::LAlt
a::LControl
s::F6
d::F5
f::F4
g::F11
h:: return
j:: return
k::Media_Play_Pause
l::Media_Prev
`;::Media_Next
'::RControl
Enter::RControl
z::LShift
x::F3
c::F2
v::F1
b::F10
n:: return
m:: return
,::PrintScreen
.::ScrollLock
/:: Pause
RShift::RShift
#HotIf

; wide colemak_dh_jk. remove if not needed
e::f
r::p
t::b
u::k
i::l
o::u
p::y
[::;
s::r
d::s
f::t
j::m
k::n
l::e
`;::i
'::o
v::d
b::v
m::j
,::h
; $^v::^v ; keep ^v
; $^b::^d ; for keeping ^v
; $#v::#v ; keep ^v
; $#b::#d ; for keeping ^v

; extra symbol remaps based on layers. remove if not needed
y:: return
h:: return
n::_
Tab::LWin
]::RShift
\::RWin
PrintScreen::RControl
Delete::^w
