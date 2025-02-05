#Requires AutoHotkey v2.0
#SingleInstance Force

setKeyboard("
(
``    1     2     3     4     5     6     7     8     9     0     -     =       BS

Tab      q     w     e     r     t     y     u     i     o     p     [     ]     \

CapsLock  a     s     d     f     g     h     j     k     l     ;     '      Enter

LShift       z     x     c     v     b     n     m     ,     .     /        RShift

LCtrl LWin LAlt                    Space                        RAlt AppsKey RCtrl
)"
)

setLayer("", "
(
^     +     -     =     _     ``    %     #     *     {     }     [     ]        $

Tab      b     w     u     c     y     q     /     k     o     ;     (     )     \

LCtrl     i     a     s     g     z     f     h     e     l     t     '      Enter

LShift       x     d     r     v     p     n     m     j     ,     .        RShift

LCtrl LWin LAlt                    Space                           LAlt Rwin RCtrl
)"
)

setLayer("Space", "
(
F12   F1    F2    F3    F4    F5    F6    F7    F8    F9    F10   F11   PrintScreen  Volume_Up

LAlt     Tab   BS    Up    PgUp  Home  &     7     8     9     @     LAlt  AppsKey Volume_Mute

LCtrl     Esc   Left  Enter Right Ins   !     1     2     3     0     RCtrl        Volume_Down

LShift    CapsLock Down  PgDn  Del   End   |     4     5     6     ~                    RShift

LCtrl LWin LAlt                    Space                                       LAlt Rwin RCtrl
)"
)

key2index := Map()

setKeyboard(str) {
for index, key in convertLayer(str)
    key2index[key] := index
}

leader2layer := Map()

setLayer(leader, str) {
    leader2layer[leader] := convertLayer
(str)
    for key in key2index {
        hKey := leader = "" ? "*" key : leader " & " key
        Hotkey hKey, sendLayeredKey
        Hotkey hKey " Up", sendLayeredKey
    }
}

sendLayeredKey(hKey) {
    array := StrSplit(hKey, " & ")
    leader := array.Length = 1 ? "" : array[1]
    layer := leader2layer[leader]
    keyWithUp := array.Length = 1 ? SubStr(array[1], 2) : array[2]
    array := StrSplit(keyWithUp, " ")
    key := array[1]
    index := key2index[key]
    result := layer[index]
    postfix := array.Length = 1 ? "Down" : "Up"
    Send("{Blind}{" result " " postfix "}")
}

convertLayer(str) {
    str := StrReplace(str, "`n", " ")
    loop {
        str := StrReplace(str, "  ", " ", , &count)
        if count = 0
            break
    }
    return StrSplit(str, " ")
}
