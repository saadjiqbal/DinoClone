extends Node2D

# EXPORT VARIABLES:
@export var background_layer_speed: int = 0
@export var large_cloud_layer_speed: int = 0
@export var small_cloud_layer_speed: int = 0
@export var foreground_layer_speed: int = 0

# ON READY VARIABLES:
@onready var background_layer: Node2D = $BackgroundLayer
@onready var large_cloud_layer: Node2D = $LargeCloudLayer
@onready var small_cloud_layer: Node2D = $SmallCloudLayer
@onready var foreground_layer: Node2D = $ForegroundLayer

var layers : Array

func _ready():
	# Create array of layers once when the scene is instantiated
	layers = [background_layer, large_cloud_layer, small_cloud_layer, foreground_layer]

func _process(delta):
	# If any of the layers go off the screen, reset their position to 0
	for i in layers.size():
		if (layers[i].position.x < -1280):
			layers[i].position.x = 0
	
	background_layer.position.x -= (background_layer_speed * delta)
	large_cloud_layer.position.x -= (background_layer_speed * delta)
	small_cloud_layer.position.x -= (small_cloud_layer_speed * delta)
	foreground_layer.position.x -= (foreground_layer_speed * delta)
