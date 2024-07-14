extends Area2D

# CONSTANTS:
const SPEED : int = 10

# VARIABLES:
@onready var small_cactus : Area2D = $"."

func _ready() -> void:
	pass

func _physics_process(_delta) -> void:
	small_cactus.position.x -= SPEED
