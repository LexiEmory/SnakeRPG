extends Node2D

func _ready():
	set_process(true)
	#get_node("Camera2D").set_owner(get_node("Character/Head"))
	pass

func _process(delta):
	get_node("Character")._set_target(get_global_mouse_pos())
	get_node("Camera2D").set_pos(get_node("Character/Head").get_pos())
	pass