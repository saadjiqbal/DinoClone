extends CharacterBody2D

const GRAVITY = 5000
const JUMP_VELOCITY = -1000

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var running_collision_shape: CollisionShape2D = $RunningCollisionShape2D

func _physics_process(delta):
    velocity.y += GRAVITY * delta

    if is_on_floor():
        running_collision_shape.disabled = false
        # Handle jump.
        if Input.is_action_pressed("jump"):
            velocity.y = JUMP_VELOCITY
        elif Input.is_action_pressed("crouch"):
            animated_sprite_2d.play("slide")
            running_collision_shape.disabled = true
        else:
            animated_sprite_2d.play("run")
    else:
        animated_sprite_2d.play("jump")

    move_and_slide()
