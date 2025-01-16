#Requires AutoHotkey v2.0
#SingleInstance Force

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

; capslock -> ctrl & esc
SetCapsLockState 'AlwaysOff'
*CapsLock:: Send "{LControl down}"
*CapsLock up::
{
    Send "{LControl Up}"
    if (A_PriorKey == "CapsLock") {
        if (A_TimeSincePriorHotkey < 1000)
            Suspend "1"
        Send "{Esc}"
        Suspend "0"
    }
}

; edit nav num
Space::Space
Space & Tab::LAlt
Space & q::LWin
Space & w::BackSpace
Space & e::Up
Space & r::Delete
Space & t::PgUp
Space & y:: return
Space & u::AppsKey
Space & i::7
Space & o::8
Space & p::9
Space & [::RWin
Space & ]::RShift
Space & \::LAlt
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
>!Tab:: return
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
>!]:: return
>!\:: return
>!CapsLock::LControl
>!a:::
>!s::"
>!d::`{
>!f::}
>!g::`
>!h:: return
>!j::|
>!k::(
>!l::)
>!`;::_
>!'::'
>!Enter::RControl
>!LShift::LShift
>!z::?
>!x::\
>!c::<
>!v::>
>!b::~
>!n:: return
>!m::+
>!,::[
>!.::]
>!/:: return

; layer 4 - func media

<!Space:: return
<!q::LAlt
<!w::F9
<!e::F8
<!r::F7
<!t::F12
<!y:: return
<!u:: return
<!i::Volume_Mute
<!o::Volume_Down
<!p::Volume_Up
<![::LAlt
<!]::RShift
<!\:: return
<!CapsLock::LControl
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
<!LShift::LShift
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
<!RShift:: return

; extra symbol remaps based on layers. remove if not needed
y::BackSpace
]::-
\::=
n::_
-::Volume_Down
=::Volume_Up
BackSpace::Volume_Mute
Delete::^w
