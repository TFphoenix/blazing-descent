extends Control

@onready var bar_overheat = $HBoxContainer/Bar_Overheat
@onready var bar_progress = $HBoxContainer/Bar_Progress
@onready var label_timer = $VBoxContainer/Label_Timer
@onready var label_level = $VBoxContainer/Label_Level

const TEXT_TIMER = "Time: %02d:%02d.%03d"
const TEXT_LEVEL = "Level %2d"


func update_overheat(overheat: float):
	bar_overheat.value = overheat


func update_progress(progress: float):
	bar_progress.value = progress


func update_timer(time: float):
	var m = int(floor(time / 60))
	var s = int(floor(time))
	var ms = int(time * 1000) % 1000
	label_timer.text = TEXT_TIMER % [m, s, ms]


func update_level(level: int):
	label_level.text = TEXT_LEVEL % level
