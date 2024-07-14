extends Area2D

# CONSTANTS:
const SPEED : int = 10

# ON READY VARIABLES:
@onready var bird : Area2D = $"."

func _ready():
	pass

func _physics_process(delta):
	bird.position.x -= SPEED

