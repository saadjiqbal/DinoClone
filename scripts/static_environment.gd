extends Node2D

@onready var layer_0: Node2D = $Layer0
@onready var layer_1: Node2D = $Layer1
@onready var layer_2: Node2D = $Layer2
@onready var layer_3: Node2D = $Layer3

@export var layer_0_speed: int = 0
@export var layer_1_speed: int = 0
@export var layer_2_speed: int = 0
@export var layer_3_speed: int = 0

func _process(delta):
	for i in [layer_0, layer_1, layer_2, layer_3]:
		if (i.position.x < -1280.0):
			i.position.x = 0.0
	layer_0.position.x -= (layer_0_speed * delta)
	layer_1.position.x -= (layer_1_speed * delta)
	layer_2.position.x -= (layer_2_speed * delta)
	layer_3.position.x -= (layer_3_speed * delta)
