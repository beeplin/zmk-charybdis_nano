#Requires AutoHotkey v2.0
#SingleInstance Force

layer_0_wide_qwerty := create_layer("
(
    LWin     q w e r t \      y u i o p [ ]
    CapsLock a s d f g Enter  h j k l ; '
    LShift   z x c v b RShift n m , . /
)"
)

layer_1_wide_colemak_dhm_jk := create_layer("
(
    LWin     q w f p b \      k l u y ; [ ]
    CapsLock a r s t g Enter  m n e i o '
    LShift   z x c d v RShift j h , . /
)"
)

layer_2_wide_edit_nav_num := create_layer("
(
    LWin   LAlt BS   Up   Del   PgUp \ AppsKey  7 8 9 LAlt RShift RWin
    LCtrl  Esc  Left Down Right Tab  \ CapsLock 4 5 6 0    RCtrl
    LShift Ins  Home End  Enter PgDn \ CapsLock 1 2 3 RShift
)"
)

layer_3_wide_symbol := create_layer("
(
    LWin   ! @ # $ % \ ^ & * | \ RShift RWin
    LCtrl  ' " ` { } \ ) ( = - + RCtrl
    LShift ? \ ~ [ ] \ > _ < > ?
)"
)

layer_4_wide_func_media := create_layer("
(
    LWin   LAlt   F9 F8 F7 F12 \ \ Volume_Mute      Volume_Down Volume_Up  LAlt  RShift RWin
    LCtrl  LCtrl  F6 F5 F4 F11 \ \ Media_Play_Pause Media_Prev  Media_Next RCtrl RCtrl
    LShift LShift F3 F2 F1 F10 \ \ PrintScreen      ScrollLock  Pause      RShift
)"
)

layer_qwerty := create_layer("
(
    LWin     q w e r t y u i o p [ ] \
    CapsLock a s d f g h j k l ; ' Enter
    LShift   z x c v b n m , . / RShift
)"
)

layer_default := layer_1_wide_colemak_dhm_jk

enable_layer(layer_default)

$^v::^v ; keep ^v
$^b::^d ; for keeping ^v
$#v::#v ; keep ^v
$#b::#d ; for keeping ^v

Space:: setup_layer(layer_2_wide_edit_nav_num, "Space")
Space Up:: setup_layer(layer_default, "Space", "Up")

RAlt:: setup_layer(layer_3_wide_symbol, "RAlt")
RAlt Up:: setup_layer(layer_default, "RAlt", "Up")

RShift:: setup_layer(layer_3_wide_symbol, "RShift")
RShift Up:: setup_layer(layer_default, "RShift", "Up")

LAlt:: setup_layer(layer_4_wide_func_media, "LAlt")
LAlt Up:: setup_layer(layer_default, "LAlt", "Up")

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

create_layer(str) {
    str := StrReplace(str, "`n", " ")
    loop {
        str := StrReplace(str, "  ", " ", , &Count)
        if (Count = 0)
            break
    }
    return StrSplit(str, " ")
}

enable_layer(layer) {
    for index, key in layer_default {
        Hotkey key, (k) => send_layered_key(k, layer), "On"
    }
}

prefix_when_pressed := {}

setup_layer(layer, leader, status?) {
    enable_layer(layer)
    if (status = "Up") {
        if (A_PriorKey = leader) {
            if (A_TimeSincePriorHotkey < 1000)
                Suspend "1"
            global prefix_when_pressed
            Send prefix_when_pressed.%leader% "{" leader "}"
            Suspend "0"
            prefix_when_pressed := ""
        }
    }
    else {
        global prefix_when_pressed
        prefix_when_pressed.%leader% := get_modifiers()
    }
}

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

index_of_key := {
    Tab: 1, q: 2, w: 3, e: 4, r: 5, t: 6, y: 7, u: 8, i: 9, o: 10, p: 11, %"["%: 12, %"]"%: 13, %"\"%: 14,
    CapsLock: 15, a: 16, s: 17, d: 18, f: 19, g: 20, h: 21, j: 22, k: 23, l: 24, %";"%: 25, %"'"%: 26, Enter: 27,
    LShift: 28, z: 29, x: 30, c: 31, v: 32, b: 33, n: 34, m: 35, %","%: 36, %"."%: 37, %"/"%: 38, RShift: 39,
}

send_layered_key(key, layer) {
    result := get_modifiers() "{" layer[index_of_key.%key%] "}"
    ; MsgBox result
    Send(result)

}
; ; wide qwerty
; y::\
; u::y
; i::u
; o::i
; p::o
; [::p
; ]::[
; \::]
; h::Enter
; j::h
; k::j
; l::k
; `;::l
; '::`;
; Enter::'
; n::RShift
; m::n
; ,::m
; .::,
; /::.
; RShift::/

; ; tab -> win, preserve alt-tab
; Tab::LWin
; ; <!Tab::AltTab

; ; ; fix for layer 4 alt+fx. must be above all layer detinitions
; ; #HotIf (GetKeyState("LAlt", "P") && !GetKeyState("Space", "P"))
; ; q & w::!F9
; ; q & e::!F8
; ; q & r::!F7
; ; q & t::!F12
; ; q & s::!F6
; ; q & d::!F5
; ; q & f::!F4
; ; q & g::!F11
; ; q & x::!F3
; ; q & c::!F2
; ; q & v::!F1
; ; q & b::!F10
; ; [ & w::!F9
; ; [ & e::!F8
; ; [ & r::!F7
; ; [ & t::!F12
; ; [ & s::!F6
; ; [ & d::!F5
; ; [ & f::!F4
; ; [ & g::!F11
; ; [ & x::!F3
; ; [ & c::!F2
; ; [ & v::!F1
; ; [ & b::!F10
; ; #HotIf

; ; layer 2 - edit nav num
; Space::Space
; Space & q::LAlt
; Space & w::BackSpace
; Space & e::Up
; Space & r::Delete
; Space & t::PgUp
; Space & y:: return
; Space & u::AppsKey
; Space & i::7
; Space & o::8
; Space & p::9
; Space & [::LAlt
; Space & ]::RShift
; Space & \::RWin
; Space & a::Escape
; Space & s::Left
; Space & d::Down
; Space & f::Right
; Space & g::Tab
; Space & h:: return
; Space & j::CapsLock
; Space & k::4
; Space & l::5
; Space & `;::6
; Space & '::0
; Space & Enter::RControl
; Space & z::Insert
; Space & x::Home
; Space & c::End
; Space & v::Enter
; Space & b::PgDn
; Space & n:: return
; Space & m::CapsLock
; Space & ,::1
; Space & .::2
; Space & /::3
; Space & RShift::RShift

; ; layer 3 - symbol
; RAlt:: return
; >!q::!
; >!w::@
; >!e::#
; >!r::$
; >!t::%
; >!y:: return
; >!u::^
; >!i::&
; >!o::*
; >!p::-
; >![::=
; >!]::RShift
; >!\::RWin
; >!a::'
; >!s::"
; >!d::`
; >!f::`{
; >!g::}
; >!h:: return
; >!j::)
; >!k::(
; >!l::|
; >!`;::+
; >!':::
; >!Enter::RControl
; >!z::\
; >!x::|
; >!c::~
; >!v::[
; >!b::]
; >!n:: return
; >!m::>
; >!,::_
; >!.::<
; >!/::>
; >!RShift::?

; ; ; layer 4 - func media
; ; LAlt:: return
; ; <!q::LAlt ; see fix above
; ; <!w::F9
; ; <!e::F8
; ; <!r::F7
; ; <!t::F12
; ; <!y:: return
; ; <!u:: return
; ; <!i::Volume_Mute
; ; <!o::Volume_Down
; ; <!p::Volume_Up
; ; <![::LAlt ; see fix above
; ; <!]::RShift
; ; <!\::RWin
; ; <!a::LControl
; ; <!s::F6
; ; <!d::F5
; ; <!f::F4
; ; <!g::F11
; ; <!h:: return
; ; <!j:: return
; ; <!k::Media_Play_Pause
; ; <!l::Media_Prev
; ; <!`;::Media_Next
; ; <!'::RControl
; ; <!Enter::RControl
; ; <!z::LShift
; ; <!x::F3
; ; <!c::F2
; ; <!v::F1
; ; <!b::F10
; ; <!n:: return
; ; <!m:: return
; ; <!,::PrintScreen
; ; <!.::ScrollLock
; ; <!/:: Pause
; ; <!RShift::RShift

; ; wide colemak_dh_jk. remove if not needed
; e::f
; r::p
; t::b
; u::k
; i::l
; o::u
; p::y
; [::;
; s::r
; d::s
; f::t
; j::m
; k::n
; l::e
; `;::i
; '::o
; v::d
; b::v
; m::j
; ,::h
; $^v::^v ; keep ^v
; $^b::^d ; for keeping ^v
; $#v::#v ; keep ^v
; $#b::#d ; for keeping ^v

; ; extra symbol remaps based on layers. remove if not needed
; y::BackSpace
; ]::-
; \::=
; n::_
; Delete::^w
