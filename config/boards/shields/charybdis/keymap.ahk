#Requires AutoHotkey v2.0
#SingleInstance Force

LShift::z
; <+a::F11
; <+s::Left

#HotIf GetKeyState("LShift", "P")

c::d
z::x
x::c

HotIf
