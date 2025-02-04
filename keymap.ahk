#Requires AutoHotkey v2.0
#SingleInstance Force
; #UseHook true

`::`
1::^
2::=
3::_
4::-
5::+
6::#
7::*
8::`{
+8::}
9::(
+9::)
0::$
-::%
=::)
BackSpace::BackSpace
Tab::LAlt
q::q
w::w
e::u
r::p
t::b
y::f
u::h
i::k
o::l
p::;
[::[
+[::]
]::]
\::}
CapsLock::LCtrl
a::a
s::s
d::d
f::t
g::g
h::m
j::n
k::e
l::i
`;::o
'::'
Enter::"
LShift::LShift
z::z
x::x
c::c
v::v
b::y
n::j
m::r
,::,
.::.
/::/
RShift::\

Space::Space
Space & `::F12
Space & 1::F1
Space & 2::F2
Space & 3::F3
Space & 4::F4
Space & 5::F5
Space & 6::F6
Space & 7::F7
Space & 8::F8
Space & 9::F9
Space & 0::F10
Space & -::F11
Space & Tab::LAlt
Space & q::Tab
Space & w::BackSpace
Space & e::Up
Space & r::Delete
Space & t::PgUp
Space & y::&
Space & u::7
Space & i::8
Space & o::9
Space & p::@
Space & [::LAlt
Space & CapsLock::LCtrl
Space & a::Escape
Space & s::Left
Space & d::Down
Space & f::Right
Space & g::PgDn
Space & h::!
Space & j::1
Space & k::2
Space & l::3
Space & `;::0
Space & '::RCtrl
space & LShift::LShift
Space & z::CapsLock
Space & x::Home
Space & c::Insert
Space & v::Enter
Space & b::End
Space & n::|
Space & m::4
Space & ,::5
Space & .::6
Space & /::~
Space & RShift::RShift
Space & RAlt::RShift

LAlt:: return
#HotIf (GetKeyState("LAlt", "P"))
w::Volume_Down
e::Volume_Mute
r::Volume_Up
s::Media_Prev
d::Media_Play_Pause
f::Media_Next
z::AppsKey
x::PrintScreen
c::ScrollLock
v:: Pause
b::F10
#HotIf
