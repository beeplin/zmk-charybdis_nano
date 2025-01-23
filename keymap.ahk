#Requires AutoHotkey v2.0
#SingleInstance Force
; #UseHook true

SetCapsLockState 'AlwaysOff'

; win + capslock -> capslock
#CapsLock::CapsLock

; capslock -> ctrl when held, esc when tapped
*CapsLock:: hold_tap_down("LCtrl", "Esc")
*CapsLock Up:: hold_tap_up("LCtrl", "Esc", "CapsLock")

; enter -> ctrl when held, enter when tapped
*Enter:: hold_tap_down("RCtrl", "Enter")
*Enter Up:: hold_tap_up("RCtrl", "Enter", "Enter")

; layer 1 - default

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
Tab::AltTab
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
z::LShift
x::F3
c::F2
v::F1
b::F10
n:: return
m::Launch_App2
,::PrintScreen
.::ScrollLock
/:: Pause
RShift::RShift
#HotIf

; extra remaps based on layers. remove if not needed
y:: return
h:: return
n:: return
Tab::LWin
]::RShift
\::RWin
PrintScreen::RControl
Delete::^w

; tool functions

prefixes := {}

hold_tap_down(hold, tap) {
    Send "{" hold " Down}"
    global prefixes
    prefixes.%tap% := get_modifiers()
}

hold_tap_up(hold, tap, physical) {
    Send "{" hold " Up}"
    global prefixes
    if (A_PriorKey = physical) {
        if (A_TimeSincePriorHotkey < 1000)
            Suspend "1"
        Send prefixes.%tap% "{" tap "}"
        Suspend "0"
        prefixes.%tap% := ""
    }
}

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
