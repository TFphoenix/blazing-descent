extends Control

@onready var bar_overheat = $HBoxContainer/Bar_Overheat
@onready var bar_progress = $HBoxContainer/Bar_Progress
@onready var label_timer = $VBoxContainer/Label_Timer
@onready var label_level = $VBoxContainer/Label_Level
@onready var dialog_end = $Dialog_End
@onready var end_pass = $End_Pass
@onready var end_fail = $End_Fail

const TEXT_TIMER = "Time: %02d:%02d.%03d"
const TEXT_LEVEL = "Level %2d"

signal restart_level
signal end_run
signal next_level


func update_overheat(overheat: float):
	bar_overheat.value = overheat


func update_progress(progress: float):
	bar_progress.value = progress


func update_timer(time: float):
	var m = int(floor(time / 60))
	var s = int(floor(time)) % 60
	var ms = int(time * 1000) % 1000
	label_timer.text = TEXT_TIMER % [m, s, ms]


func update_level(level: int):
	label_level.text = TEXT_LEVEL % level


func display_passed():
	end_pass.visible = true


func display_failed():
	end_fail.visible = true


func _on_button_restart_pressed():
	end_fail.visible = false
	restart_level.emit()


func _on_button_end_pressed():
	dialog_end.visible = true
	dialog_end.confirmed.connect(_on_end_confirmed)


func _on_end_confirmed():
	end_run.emit()


func _on_button_next_level_pressed():
	end_pass.visible = false
	next_level.emit()
