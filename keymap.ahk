#Requires AutoHotkey v2.0
#SingleInstance Force

A_MaxHotkeysPerInterval := 200

layer_0_wide_qwerty := create_layer("
(
    LWin q w e r t \      y u i o p [ ]
         a s d f g Enter  h j k l ; '
         z x c v b RShift n m , . /
)"
)

layer_1_wide_colemak_dhm_jk := create_layer("
(
    LWin q w f p b \      k l u y ; [ ]
         a r s t g Enter  m n e i o '
         z x c d v RShift j h , . /
)"
)

layer_2_wide_edit_nav_num := create_layer("
(
    LWin LAlt BS   Up   Del   PgUp \ AppsKey  7 8 9 LAlt RShift RWin
         Esc  Left Down Right Tab  \ CapsLock 4 5 6 0    RControl
         Ins  Home End  Enter PgDn \ CapsLock 1 2 3 RShift
)"
)

layer_3_wide_symbol := create_layer("
(
    LWin ! @ #  $ % \ ^ & * | \ RShift RWin
         ' " `` { } \ ) ( = - + RControl
         ? \ ~  [ ] \ > _ < > ?
)"
)

layer_4_wide_func_media := create_layer("
(
    LWin LAlt     F9 F8 F7 F12 \ \ Volume_Mute      Volume_Down Volume_Up  LAlt     RShift RWin
         LControl F6 F5 F4 F11 \ \ Media_Play_Pause Media_Prev  Media_Next RControl RControl
         LShift   F3 F2 F1 F10 \ \ PrintScreen      ScrollLock  Pause      RShift
)"
)

layer_qwerty := create_layer("
(
    LWin q w e r t y u i o p [ ] \
         a s d f g h j k l ; ' Enter
         z x c v b n m , . / RShift
)"
)

layer_default := layer_1_wide_colemak_dhm_jk
layer_default := layer_qwerty

; wide colemak_dh_jk. remove if not needed
Tab::LWin
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
.::,
/::.
RShift::/
$^v::^v ; keep ^v
$^b::^d ; for keeping ^v
$#v::#v ; keep ^v
$#b::#d ; for keeping ^v

Space:: setup_layer(layer_2_wide_edit_nav_num, "Space")
Space Up:: setup_layer(layer_default, "Space", "Up")

RAlt:: setup_layer(layer_3_wide_symbol, "RAlt")
RAlt Up:: setup_layer(layer_default, "RAlt", "Up")

; RShift:: setup_layer(layer_3_wide_symbol, "RShift")
; RShift Up:: setup_layer(layer_default, "RShift", "Up")

LAlt:: setup_layer(layer_4_wide_func_media, "LAlt")
LAlt Up:: setup_layer(layer_default, "LAlt", "Up")

; capslock -> control & esc
SetCapsLockState 'AlwaysOff'
prefix_for_esc := ""
*CapsLock:: {
    Send "{LControl Down}"
    global prefix_for_esc
    prefix_for_esc := get_modifiers()
}
*CapsLock Up:: {
    Send "{LControl Up}"
    global prefix_for_esc
    if (A_PriorKey = "CapsLock") {
        if (A_TimeSincePriorHotkey < 1000)
            Suspend "1"
        Send prefix_for_esc "{Esc}"
        Suspend "0"
        prefix_for_esc := ""
    }
}

create_layer(str) {
    str := StrReplace(str, "`n", " ")
    loop {
        str := StrReplace(str, "  ", " ", , &Count)
        if (Count = 0)
            break
    }
    return StrSplit(str, " ")
}

prefix_when_press := {}

setup_layer(layer, leader, status := "Down") {
    toggle_layer(layer, status)
    if (status = "Up") {
        if (A_PriorKey = leader) {
            if (A_TimeSincePriorHotkey < 1000)
                Suspend "1"
            global prefix_when_press
            Send prefix_when_press.%leader% "{" leader "}"
            prefix_when_press.%leader% := ""
            Suspend "0"
        }
    }
    else {
        global prefix_when_press
        prefix_when_press.%leader% := get_modifiers()
    }
}

toggle_layer(layer, status) {
    for index, key in layer_qwerty {
        if (status = "Up") {
            Hotkey key, "Off"
        }
        else {
            Hotkey key, (k) => send_layered_key(k, layer), "On"
        }
    }
    return 0
}

send_layered_key(key, layer) {
    result := get_modifiers() "{" layer[index_of_key.%key%] "}"
    MsgBox result
    Send result
}

get_modifiers() {
    prefix := ""
    if (GetKeyState("LControl", "P") || GetKeyState("RControl", "P"))
        prefix := "^"
    if (GetKeyState("LShift", "P") || GetKeyState("RShift", "P"))
        prefix := prefix "+"
    if ((GetKeyState("LAlt", "P") || GetKeyState("RAlt", "P")) && (GetKeyState("q", "P") || GetKeyState("[", "P")))
        prefix := prefix "!"
    if (GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
        prefix := prefix "#"
    return prefix
}

index_of_key := {
    Tab: 1, q: 2, w: 3, e: 4, r: 5, t: 6, y: 7, u: 8, i: 9, o: 10, p: 11, %"["%: 12, %"]"%: 13, %"\"%: 14,
    a: 15, s: 16, d: 17, f: 18, g: 19, h: 20, j: 21, k: 22, l: 23, %";"%: 24, %"'"%: 25, Enter: 26,
    z: 27, x: 28, c: 29, v: 30, b: 31, n: 32, m: 33, %","%: 34, %"."%: 35, %"/"%: 36, RShift: 37,
}
