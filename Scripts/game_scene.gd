extends Node2D

@onready var pipe_group: Node = $Pipes
@onready var pipe_timer: Timer = $PipeSpawn
@onready var pipe_scene: PackedScene = load("res://Scenes/pipe.tscn")
var end_game_scene: PackedScene
@onready var pipe_spawner: Node2D = $PipeSpawner
@onready var score_label: Label = $"UI Background/Score Label"
@onready var game_center: Control = $Background/GameCenter

signal move_pipe(slide_amount)

func _ready():
	spawn_pipe()

#Process to run every frame
func _physics_process(delta):
	move_pipes(delta)

#Spawns the pipes off screen
func spawn_pipe():
	var pipe_instance: Node2D = pipe_scene.instantiate()
	var y_offset: int = RandomNumberGenerator.new().randi_range(315,945)
	var pipe_position: Vector2 = Vector2(pipe_spawner.get_global_position().x, pipe_spawner.get_global_position().y - y_offset)
	pipe_instance.set_global_position(pipe_position)
	pipe_group.add_child(pipe_instance)
	pipe_instance.get_node("BottomPipe").body_entered.connect(pipe_entered)
	pipe_instance.get_node("TopPipe").body_entered.connect(pipe_entered)
	pipe_instance.get_node("ScoreBound").body_entered.connect(add_score)

#Moves the pipes to the left on the screen
func move_pipes(delta):
	var slide_amount = 100 * delta
	emit_signal("move_pipe",slide_amount)

func _on_death_barrier_body_entered(body):
	if body.name == "Player":
		game_over()

func pipe_entered(body: Node2D):
	if body.name == "Player":
		game_over()

func add_score(body: Node2D):
	if body.name == "Player":
		GameData.score += 1
		score_label.set_text("Score: " + str(GameData.score))


func _on_pipe_spawn_timeout():
	spawn_pipe()

func game_over():
	get_tree().set_pause(true)
	if GameData.score > GameData.high_score:
		GameData.high_score = GameData.score
	end_game_scene = load("res://Scenes/EndGame.tscn")
	var end_game = end_game_scene.instantiate()
	end_game.get_node("Background/Labels/ScoreLabel").set_text("Score: " + str(GameData.score))
	end_game.get_node("Background/Labels/HighScoreLabel").set_text("High Score: " + str(GameData.high_score))
	game_center.add_child(end_game)
	
