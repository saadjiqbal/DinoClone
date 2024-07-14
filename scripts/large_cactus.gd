extends Area2D

# CONSTANTS:
const SPEED : int = 10

# ON READY VARIABLES:
@onready var large_cactus : Area2D = $"."

func _ready():
	pass

func _physics_process(delta):
	large_cactus.position.x -= SPEED

