extends CharacterBody2D


const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	if GameData.playing:
		# Add the gravity.
		velocity.y += (gravity * delta)
		
		# Handle jump.
		
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
		
		move_and_slide()
