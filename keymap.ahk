#Requires AutoHotkey v2.0
#SingleInstance Force

get_modifiers(*) {
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

; capslock -> ctrl & esc
SetCapsLockState 'AlwaysOff'
prefix_for_esc := ""
*CapsLock:: {
    Send "{LCtrl down}"
    global prefix_for_esc
    prefix_for_esc := get_modifiers()
}
*CapsLock up:: {
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

; wide qwerty
y::\
u::y
i::u
o::i
p::o
[::p
]::[
\::]
h::Enter
j::h
k::j
l::k
`;::l
'::`;
Enter::'
n::RShift
m::n
,::m
.::,
/::.
RShift::/

; tab -> win, preserve alt-tab
Tab::LWin
<!Tab::AltTab

; fix for layer 4 alt+fx. must be above all layer detinitions
#HotIf (GetKeyState("LAlt", "P") && !GetKeyState("Space", "P"))
q & w::!F9
q & e::!F8
q & r::!F7
q & t::!F12
q & s::!F6
q & d::!F5
q & f::!F4
q & g::!F11
q & x::!F3
q & c::!F2
q & v::!F1
q & b::!F10
[ & w::!F9
[ & e::!F8
[ & r::!F7
[ & t::!F12
[ & s::!F6
[ & d::!F5
[ & f::!F4
[ & g::!F11
[ & x::!F3
[ & c::!F2
[ & v::!F1
[ & b::!F10
#HotIf

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
Space & ]::RShift
Space & \::RWin
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

; layer 3 - symbol with ralt
RAlt:: return
>!q::!
>!w::@
>!e::#
>!r::$
>!t::%
>!y:: return
>!u::^
>!i::&
>!o::*
>!p::-
>![::=
>!]::RShift
>!\::RWin
>!a::`
>!s::-
>!d::=
>!f::`{
>!g::}
>!h:: return
>!j::)
>!k::(
>!l::'
>!`;::"
>!':::
>!Enter::RControl
>!z::~
>!x::\
>!c::|
>!v::[
>!b::]
>!n:: return
>!m::+
>!,::_
>!.::<
>!/::>
>!RShift::?

; layer 3 - symbol with rshift
>+q::!
>+w::@
>+e::#
>+r::$
>+t::%
>+y:: return
>+u::^
>+i::&
>+o::*
>+p::-
>+[::=
>+]::RShift
>+\::RWin
>+a::`
>+s::-
>+d::=
>+f::`{
>+g::}
>+h:: return
>+j::)
>+k::(
>+l::'
>+`;::"
>+':::
>+Enter::RControl
>+z::~
>+x::\
>+c::|
>+v::[
>+b::]
>+n:: return
>+m::+
>+,::_
>+.::<
>+/::>

; layer 4 - func media
LAlt:: return
<!q::LAlt ; see fix above
<!w::F9
<!e::F8
<!r::F7
<!t::F12
<!y:: return
<!u:: return
<!i::Volume_Mute
<!o::Volume_Down
<!p::Volume_Up
<![::LAlt ; see fix above
<!]::RShift
<!\::RWin
<!a::LControl
<!s::F6
<!d::F5
<!f::F4
<!g::F11
<!h:: return
<!j:: return
<!k::Media_Play_Pause
<!l::Media_Prev
<!`;::Media_Next
<!'::RControl
<!Enter::RControl
<!z::LShift
<!x::F3
<!c::F2
<!v::F1
<!b::F10
<!n:: return
<!m:: return
<!,::PrintScreen
<!.::ScrollLock
<!/:: Pause
<!RShift::RShift

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
y::BackSpace
]::-
\::=
n::_
Delete::^w
