extends Area2D

const SPEED : int = 10

@onready var bird : Area2D = $"."

func _ready():
	pass

func _physics_process(delta):
	bird.position.x -= SPEED

