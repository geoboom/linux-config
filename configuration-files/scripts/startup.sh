xset r rate 230 30 # delay, interval
xset -b # remove the stupid bell
setxkbmap -option caps:escape # map caps to escape

############################################
# Laptop (Lenovo T450s mappings)
############################################
# Note:
# - keycode 108 = Alt_R
# - Last 2 params are with mode switch and with shift + mode switch
# - `xmodmap -pke >.xmodmap.orig` to generate original mappings and `xev` to
#   see keycodes emitted
xmodmap -e "keycode 108 = Mode_switch"
xmodmap -e "keycode 43 = h H Left Left"
xmodmap -e "keycode 44 = j J Down Down"
xmodmap -e "keycode 45 = k K Up Up"
xmodmap -e "keycode 46 = l L Right Right"
xmodmap -e "keycode 47 = semicolon colon Prior Prior"
xmodmap -e "keycode 48 = apostrophe quotedbl Next Next"
xmodmap -e "keycode 34 = bracketleft braceleft Home Home"
xmodmap -e "keycode 35 = bracketright braceright End End"
xmodmap -e "keycode 10 = 1 exclam F1 F1"
xmodmap -e "keycode 11 = 2 at F2 F2"
xmodmap -e "keycode 12 = 3 numbersign F3 F3"
xmodmap -e "keycode 13 = 4 dollar F4 F4"
xmodmap -e "keycode 14 = 5 percent F5 F5"
xmodmap -e "keycode 15 = 6 asciicircum F6 F6"
xmodmap -e "keycode 16 = 7 ampersand F7 F7"
xmodmap -e "keycode 17 = 8 asterisk F8 F8"
xmodmap -e "keycode 18 = 9 parenleft F9 F9"
xmodmap -e "keycode 19 = 0 parenright F10 F10"
xmodmap -e "keycode 20 = minus underscore F11 F11"
xmodmap -e "keycode 21 = equal plus F12 F12"
xmodmap -e "keycode 51 = backslash bar Delete Delete"

# set_g502_sens

