extends Area2D

# CONSTANTS:
const SPEED : int = 10

# ON READY VARIABLES:
@onready var bird : Area2D = $"."

func _ready() -> void:
	pass

func _physics_process(_delta) -> void:
	bird.position.x -= SPEED

