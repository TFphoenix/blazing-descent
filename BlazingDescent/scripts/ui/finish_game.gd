extends Control

const TEXT_TIMER = "%02d:%02d.%03d"
@onready var label_timer = $CenterContainer/VBoxContainer/Label_Timer

signal main_menu


func _ready():
	var time = Static.time
	var m = int(floor(time / 60))
	var s = int(floor(time)) % 60
	var ms = int(time * 1000) % 1000
	label_timer.text = TEXT_TIMER % [m, s, ms]


func _on_button_main_menu_pressed():
	main_menu.emit()
