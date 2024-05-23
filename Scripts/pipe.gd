extends Node2D

@onready var GameScene = get_tree().get_first_node_in_group("MainSceneGroup")

func _ready():
	GameScene.move_pipe.connect(move_pipe)

func move_pipe(slide_amount):
	print("Starting X value: " + str(get_global_position().x))
	var new_x: int = get_global_position().x - slide_amount
	print("New X Value: " + str(new_x))
	var new_position: Vector2 = Vector2(-slide_amount, 0)
	global_translate(new_position)
