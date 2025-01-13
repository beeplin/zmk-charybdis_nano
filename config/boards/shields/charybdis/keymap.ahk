#Requires AutoHotkey v2.0
#SingleInstance Force

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

LShift::z
<+a::F11
<+s::Left
<+d::Down
<+Space::LControl

RShift::/
>+a::`
>+s::"
