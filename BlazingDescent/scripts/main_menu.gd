extends Control

signal start_game


func _on_button_start_pressed():
	start_game.emit()


func _on_button_leaderboard_pressed():
	pass # Replace with function body.


func _on_button_exit_pressed():
	get_tree().quit()
