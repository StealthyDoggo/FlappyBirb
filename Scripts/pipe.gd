extends Node2D

@onready var GameScene = get_tree().get_first_node_in_group("MainSceneGroup")

func _ready():
	GameScene.move_pipe.connect(move_pipe)

func move_pipe(slide_amount):
	global_translate(Vector2(-slide_amount, 0))
	if global_position.x < -10:
		queue_free()
