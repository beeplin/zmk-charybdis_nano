#Requires AutoHotkey v2.0
#SingleInstance Force

SetCapsLockState 'AlwaysOff'

; layer 1 - wide colemak_dh_jk

Space::Space

Tab::Tab
q::q
w::w
e::f
r::p
t::b

CapsLock::LControl
a::a
s::r
d::s
f::t
g::g

LShift::LShift
z::z
x::x
c::c
v::d
b::v

y::[
u::k
i::l
o::u
p::y
[::;
]::-
\::=

h::]
j::m
k::n
l::e
`;::i
'::o
Enter::'

n::_
m::j
,::h
.::,
/::.
RShift::/

; layer 2 - edit nav num

Space & Tab::LWin
Space & q::LAlt
Space & w::BackSpace
Space & e::Up
Space & r::Delete
Space & t::PgUp

Space & CapsLock::LControl
Space & a::Escape
Space & s::Left
Space & d::Down
Space & f::Right
Space & g::Tab

Space & LShift::LShift
Space & z::Insert
Space & x::Home
Space & c::End
Space & v::Enter
Space & b::PgDn

Space & y:: return
Space & u::AppsKey
Space & i::7
Space & o::8
Space & p::9
Space & [::LAlt
Space & ]::RShift
Space & \::RWin

Space & h:: return
Space & j::CapsLock
Space & k::4
Space & l::5
Space & `;::6
Space & '::0
Space & Enter::RControl

Space & n:: return
Space & m::CapsLock
Space & ,::1
Space & .::2
Space & /::3
Space & RShift::RShift

; layer 3 - symbol

>+Tab::LWin
>+q::!
>+w::@
>+e::#
>+r::$
>+t::%

>+CapsLock::LControl
>+a:::
>+s::"
>+d::`{
>+f::}
>+g::`

>+LShift::LShift
>+z::?
>+x::\
>+c::<
>+v::>
>+b::~

>+y:: return
>+u::^
>+i::&
>+o::*
>+p::-
>+[::=
>+]::RShift
>+\::RWin

>+h:: return
>+j::|
>+k::(
>+l::)
>+`;::_
>+'::'
>+Enter::RControl

>+n:: return
>+m::+
>+,::[
>+.::]
>+/:: return

; layer 4 - func media

Tab & Space::LWin
Tab & q::LAlt
Tab & w::F9
Tab & e::F8
Tab & r::F7
Tab & t::F12

Tab & CapsLock::LControl
Tab & a::LControl
Tab & s::F6
Tab & d::F5
Tab & f::F4
Tab & g::F11

Tab & LShift::LShift
Tab & z::LShift
Tab & x::F3
Tab & c::F2
Tab & v::F1
Tab & b::F10

Tab & y:: return
Tab & u:: return
Tab & i::Volume_Mute
Tab & o::Volume_Down
Tab & p::Volume_Up
Tab & [::LAlt
Tab & ]::RShift
Tab & \::RWin

Tab & h:: return
Tab & j:: return
Tab & k::Media_Play_Pause
Tab & l::Media_Prev
Tab & `;::Media_Next
Tab & '::RControl
Tab & Enter::RControl

Tab & n:: return
Tab & m::Sleep
Tab & ,::PrintScreen
Tab & .::ScrollLock
Tab & /:: Pause
Tab & RShift::RShift
