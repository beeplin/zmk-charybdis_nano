#Requires AutoHotkey v2.0
#SingleInstance Force

SetCapsLockState

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
~CapsLock & Space::Enter

LShift:: send "{LShift}{LShift Up}"
<+a::b
<+s::Left
<+d::Down
<+Space::LControl

RShift::/
>+a::`
>+s::"

Space & a::A
Space & b::A
Space & c::A
Space & d::A
Space & e::A
Space & f::A
Space & g::A
Space & h::A
Space & i::A
Space & j::A
Space & k::A
Space & l::A
Space & m::A
Space & n::A
Space & o::A
Space & p::A
Space & q::A
Space & r::A
Space & s::A
Space & t::A
Space & u::A
Space & v::A
Space & w::A
Space & x::A
Space & y::A
Space & z::A
Space::Space
Space & Tab::AltTab
Space & \::ShiftAltTab

Tab::Tab
tab & w::a
