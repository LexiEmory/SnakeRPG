extends Node2D

func _ready():
	set_process_input(true)
	pass

func _input(event):
	if get_parent().gameover && event.type == 1:
		get_tree().set_pause(false)
		get_parent().xp = 0
		get_parent().health = 100
		get_parent().gameover = false
		get_parent().get_node("CanvasLayer/GameOverText").hide()
		get_parent().get_node("CanvasLayer/GameOverPanel").hide()
	pass