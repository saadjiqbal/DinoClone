extends Area2D

const SPEED : int = 10

@onready var large_cactus : Area2D = $"."

func _ready():
	pass

func _physics_process(delta):
	large_cactus.position.x -= SPEED
