extends Node2D

@onready var pipe_group: Node = $Pipes
@onready var pipe_timer: Timer = $PipeSpawn
@onready var pipe_scene: PackedScene = load("res://Scenes/pipe.tscn")
@onready var pipe_spawner: Node2D = $PipeSpawner

signal move_pipe(slide_amount)

func _ready():
	spawn_pipe()

#Process to run every frame
func _physics_process(delta):
	move_pipes(delta)

#Spawns the pipes off screen
func spawn_pipe():
	var pipe_instance: Node2D = pipe_scene.instantiate()
	pipe_instance.set_global_position(pipe_spawner.get_global_position())
	pipe_group.add_child(pipe_instance)
	pipe_instance.get_node("BottomPipe").body_entered.connect(pipe_entered)
	pipe_instance.get_node("TopPipe").body_entered.connect(pipe_entered)
	pipe_instance.get_node("ScoreBound").body_entered.connect(add_score)

#Moves the pipes to the left on the screen
func move_pipes(delta):
	var slide_amount = 100 * delta
	emit_signal("move_pipe",slide_amount)

func _on_death_barrier_body_entered(body):
	pass # Replace with function body.

func _on_despawn_pipe_body_entered(body):
	pass # Replace with function body.

func pipe_entered(body: Node2D):
	if body.name == "Player":
		pass
	elif body.name == "DespawnPipe":
		pass

func add_score(body: Node2D):
	if body.name == "Player":
		GameData.score += 1
		pass


func _on_pipe_spawn_timeout():
	spawn_pipe()
