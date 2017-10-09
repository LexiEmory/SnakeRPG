extends Node2D

var ammountOfBugs = 0
var maximumBugs = 20
var bugScene = preload("res://Maps/Bug.tscn")

var xp = 0
var health = 100
var gameover = false

func _ready():
	set_process(true)
	get_node("Character").add_new_segment()
	get_node("CanvasLayer/GameOverText").hide()
	get_node("CanvasLayer/GameOverPanel").hide()
	pass

func _process(delta):
	get_node("Character")._set_target(get_global_mouse_pos())
	get_node("Camera2D").set_pos(get_node("Character/Head").get_pos())
	
	get_node("CanvasLayer/HealthProgress").set_value(health)
	get_node("CanvasLayer/XpProgress").set_value(xp)
	
	if health <= 0:
		get_tree().set_pause(true)
		get_node("CanvasLayer/GameOverText").show()
		get_node("CanvasLayer/GameOverPanel").show()
		gameover = true
	
	if xp >= 100:
		xp = 0
		get_node("Character").add_new_segment()
	
	if ammountOfBugs < maximumBugs:
		var tempBug = bugScene.instance()
		var firstBound = get_node("FirstBound").get_pos()
		var lastBound = get_node("LastBound").get_pos()
		tempBug.set_pos(Vector2(floor(rand_range(firstBound.x, lastBound.x)), floor(rand_range(firstBound.y, lastBound.y))))
		tempBug.set_z(-1)
		tempBug.add_to_group("Bugs")
		add_child(tempBug)
		ammountOfBugs += 1
		pass

func _on_Character_onBugCollide( bug ):
	ammountOfBugs -= 1
	bug.free()
	xp += 10
	health += 20
	if health >= 100:
		health = 100
	pass 


func _on_Timer_timeout():
	health -= 5
	if health <= 0:
		health = 0
	pass 
