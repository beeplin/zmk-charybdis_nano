#Requires AutoHotkey v2.0
#SingleInstance Force

layer_qwerty := create_layer("
(
``    1     2     3     4     5     6     7     8     9     0     -     =       BS

Tab      q     w     e     r     t     y     u     i     o     p     [     ]     \

CapsLock  a     s     d     f     g     h     j     k     l     ;     '      Enter

LShift       z     x     c     v     b     n     m     ,     .     /        RShift

LCtrl LWin LAlt                    Space                        RAlt AppsKey RCtrl
)"
)

layer_default := create_layer("
(
^     +     -     =     _     ``    %     #     *     {     }     [     ]        $

Tab      b     w     u     c     y     q     /     k     o     ;     (     )     \

LCtrl     i     a     s     g     z     f     h     e     l     t     '      Enter

LShift       x     d     r     v     p     n     m     j     ,     .        RShift

LCtrl LWin LAlt                    Space                           LAlt Rwin RCtrl
)"
)

layer_space := create_layer("
(
F12   F1    F2    F3    F4    F5    F6    F7    F8    F9    F10   F11   PrintScreen  Volume_Up

LAlt     Tab   BS    Up    PgUp  Home  &     7     8     9     @     LAlt  AppsKey Volume_Mute

LCtrl     Esc   Left  Enter Right Ins   !     1     2     3     0     RCtrl        Volume_Down

LShift    CapsLock Down  PgDn  Del   End   |     4     5     6     ~                    RShift

LCtrl LWin LAlt                    Space                                       LAlt Rwin RCtrl
)"
)

index_map := Map()
for index, key in layer_qwerty
    index_map[key] := index

DEFAULT := "__DEFAULT__"
layer_map := Map(
    DEFAULT, layer_default,
    "Space", layer_space,
)
for key, value in layer_map
    enable_layer(key)

create_layer(str) {
    str := StrReplace(str, "`n", " ")
    loop {
        str := StrReplace(str, "  ", " ", , &Count)
        if Count = 0
            break
    }
    return StrSplit(str, " ")
}

enable_layer(leader) {
  ；  if leader != DEFAULT
  ；      Hotkey leader, (hk) => Send("{" hk "}")
    for index, key in layer_qwerty {
        hot_key := leader = DEFAULT ? "*" key : leader " & " key
        Hotkey hot_key, send_layered_key
        Hotkey hot_key " Up", send_layered_key
    }
}

send_layered_key(hot_key) {
    array := StrSplit(hot_key, " & ")
    leader := array.Length = 1 ? DEFAULT : array[1]
    layer := layer_map[leader]
    key_with_up := array.Length = 1 ? SubStr(array[1], 2) : array[2]
    array := StrSplit(key_with_up, " ")
    key := array[1]
    index := index_map[key]
    result := layer[index]
    postfix := array.Length = 1 ? "Down" : "Up"
    Send("{Blind}{" result " " postfix "}")
}
