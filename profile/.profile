#########################
## add `alt` + `h/j/k/l` => left/up/down/right - per vim bindings
## - https://shellhell.wordpress.com/2012/01/31/hello-world/
## - https://askubuntu.com/questions/1025765/how-to-map-alt-hjkl-keys-to-arrow-keys
## - https://askubuntu.com/questions/465924/how-to-map-modifier-hjkl-to-arrow-key-functionality
#########################
xmodmap -e "keycode 64 = Mode_switch" # set Alt_l as the "Mode_switch"
xmodmap -e "keycode 43 = h H Left H" # h
xmodmap -e "keycode 44 = j J Down J" # j
xmodmap -e "keycode 45 = k K Up K" # k
xmodmap -e "keycode 46 = l L Right L" # l

## Rust stuff
. "$HOME/.cargo/env"
