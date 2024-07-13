extends Area2D

const SPEED : int = 10

@onready var small_cactus : Area2D = $"."

func _ready():
    pass

func _physics_process(delta):
    small_cactus.position.x -= SPEED