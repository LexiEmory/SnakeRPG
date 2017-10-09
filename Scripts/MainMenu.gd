extends Node2D

func _ready():
	
	pass

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event.type == 3:
		get_tree().change_scene("res://Maps/MainLevel.tscn")
	pass


func _on_QuitArea_input_event( viewport, event, shape_idx ):
	if event.type == 3:
		get_tree().quit()
	pass
