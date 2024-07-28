extends Control

@onready var bar_overheat = $HBoxContainer/Bar_Overheat
@onready var bar_progress = $HBoxContainer/Bar_Progress


func update_overheat(overheat: float):
	bar_overheat.value = overheat

func update_progress(progress: float):
	bar_progress.value = progress
