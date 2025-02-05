#Requires AutoHotkey v2.0
#SingleInstance Force

set_keyboard("
(
``    1     2     3     4     5     6     7     8     9     0     -     =       BS

Tab      q     w     e     r     t     y     u     i     o     p     [     ]     \

CapsLock  a     s     d     f     g     h     j     k     l     ;     '      Enter

LShift       z     x     c     v     b     n     m     ,     .     /        RShift

LCtrl LWin LAlt                    Space                        RAlt AppsKey RCtrl
)"
)

set_layer("", "
(
^     +     -     =     _     ``    %     #     *     {     }     [     ]        $

Tab      b     w     u     c     y     q     /     k     o     ;     (     )     \

LCtrl     i     a     s     g     z     f     h     e     l     t     '      Enter

LShift       x     d     r     v     p     n     m     j     ,     .        RShift

LCtrl LWin LAlt                    Space                           LAlt Rwin RCtrl
)"
)

set_layer("Space", "
(
F12   F1    F2    F3    F4    F5    F6    F7    F8    F9    F10   F11   PrintScreen  Volume_Up

LAlt     Tab   BS    Up    PgUp  Home  &     7     8     9     @     LAlt  AppsKey Volume_Mute

LCtrl     Esc   Left  Enter Right Ins   !     1     2     3     0     RCtrl        Volume_Down

LShift    CapsLock Down  PgDn  Del   End   |     4     5     6     ~                    RShift

LCtrl LWin LAlt                    Space                                       LAlt Rwin RCtrl
)"
)

key2index := Map()

set_keyboard(str) {
for index, key in convert_to_layer(str)
    key2index[key] := index
}


convert_to_layer(str) {
    str := StrReplace(str, "`n", " ")
    loop {
        str := StrReplace(str, "  ", " ", , &Count)
        if Count = 0
            break
    }
    return StrSplit(str, " ")
}

leader2layer := Map()

set_layer(leader, str) {
    leader2layer[leader] := convert_to_layer(str)
    for key in key2index {
        hot_key := leader = "" ? "*" key : leader " & " key
        Hotkey hot_key, send_layered_key
        Hotkey hot_key " Up", send_layered_key
    }
}

send_layered_key(hot_key) {
    array := StrSplit(hot_key, " & ")
    leader := array.Length = 1 ? DEFAULT : array[1]
    layer := leader2layer[leader]
    key_with_up := array.Length = 1 ? SubStr(array[1], 2) : array[2]
    array := StrSplit(key_with_up, " ")
    key := array[1]
    index := key2index[key]
    result := layer[index]
    postfix := array.Length = 1 ? "Down" : "Up"
    Send("{Blind}{" result " " postfix "}")
}
