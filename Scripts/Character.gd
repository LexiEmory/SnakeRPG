extends Node2D

var snakeLength = 3
var distanceBetweenSections = 100
var snakePositions = []
var snakeParts = []

var bodyTexture = preload("res://Assets/PC_Body.png")

func _ready():
	set_process(true)
	snakeParts.append(get_node("Tail"))
	snakeParts.append(get_node("Body"))
	snakeParts.append(get_node("Body1"))
	snakePositions.append(Vector2(0, 0))
	snakePositions.append(Vector2(0, 0))
	snakePositions.append(Vector2(0, 0))
	#get_node("RayCast2D").add_exception(get_node("Head"))
	#get_node("RayCast2D").add_exception(get_node("Body1"))
	#get_node("RayCast2D").add_exception(get_node("Body"))
	#get_node("RayCast2D").add_exception(get_node("Tail"))
	pass

func _set_target(target):
	#get_node("Position2D").set_pos(target)
	#get_node("RayCast2D").set_pos(get_node("Head").get_pos())
	get_node("RayCast2D").set_cast_to(target)
	if get_node("RayCast2D").is_colliding():
		get_node("Position2D").set_pos(get_node("RayCast2D").get_collision_point())
	else:
		get_node("Position2D").set_pos(target)
	pass

func add_new_segment():
	snakeLength += 1
	snakePositions.append(Vector2(0, 0))
	var newseg = Sprite.new()
	newseg.set_texture(bodyTexture)
	add_child(newseg)
	newseg.set_z(-1)
	snakeParts.append(newseg)
	pass

func _process(delta):
	var pos2D = get_node("Position2D")
	get_node("Head").set_pos(get_node("Head").get_pos().linear_interpolate(pos2D.get_pos(), delta))
	get_node("Head").look_at(pos2D.get_pos())
	get_node("Head").rotate(deg2rad(180))
	
	if get_node("Head").get_pos().distance_to(snakePositions[snakeLength - 1]) > distanceBetweenSections:
		snakePositions.append(get_node("Head").get_pos())
	
	for index in range(0, snakeLength):
		if index == snakeLength:
			snakeParts[index].look_at(get_node("Head").get_pos())
			snakeParts[index].rotate(deg2rad(180))
		else:
			snakeParts[index].look_at(snakeParts[index-1].get_pos())
			snakeParts[index].rotate(deg2rad(180))
		snakeParts[index].set_pos(snakePositions[index])
	
	if (snakePositions.size() > snakeLength):
		snakePositions.pop_front()
	pass