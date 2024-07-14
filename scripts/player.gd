extends CharacterBody2D

# CONSTANTS:
const GRAVITY = 5000
const JUMP_VELOCITY = -1500

# ON READY VARIABLES:
@onready var player_animated_sprite_2d : AnimatedSprite2D = $PlayerAnimatedSprite2D
@onready var running_collision_shape : CollisionShape2D = $RunningCollisionShape2D
@onready var crouching_collision_shape : CollisionShape2D = $CrouchingCollisionShape2D2 

func _physics_process(delta):
	velocity.y += GRAVITY * delta

	if is_on_floor():
		# Enable collision shape for running if we're touching the floor

		# Handle jump.
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_VELOCITY
		elif Input.is_action_pressed("crouch"):
			player_animated_sprite_2d.play("crouch")
			# Disable collision shape for running if we're crouching
		else:
			player_animated_sprite_2d.play("run")
	else:
		player_animated_sprite_2d.play("jump")

	move_and_slide()
