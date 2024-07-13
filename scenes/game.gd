extends Node2D

@onready var ground : StaticBody2D = $Ground

# Preload all obstacle scenes
var large_cactus_scene = preload("res://scenes/large_cactus.tscn")
var small_cactus_scene = preload("res://scenes/small_cactus.tscn")
var bird_scene = preload("res://scenes/bird.tscn")

var ground_height : int
var screen_size : Vector2i

var obstacle_speed := 2

# We can't add the bird scene into here as the bird is an animated sprite. 
var obstacles = [large_cactus_scene, small_cactus_scene]
var bird_heights = [200, 300, 400]

func _ready():
	ground_height = ground.get_node("Sprite2D").texture.get_height()
	screen_size = get_window().size
	generate_obstacles()

func _process(delta):
	# This will be used for score update and game difficulty
	pass

func generate_obstacles():
	var new_obstacle = obstacles[randi() % obstacles.size()].instantiate()
	var new_obstacle_h = new_obstacle.get_node("Sprite2D").texture.get_height()

	var new_obstacle_x_pos = 1000
	var new_obstacle_y_pos = screen_size.y - ground_height - (new_obstacle_h / 2)

	new_obstacle.position = Vector2i(new_obstacle_x_pos, new_obstacle_y_pos)

	add_child(new_obstacle)

	# Currently 50% chance to generate bird but this should be tied to game difficulty.
	if (randi() % 2) == 0:
		var bird = bird_scene.instantiate()
		var bird_x_pos = 1000
		var bird_y_pos = bird_heights[randi() % bird_heights.size()]

		bird.position = Vector2i(bird_x_pos, bird_y_pos)
		add_child(bird)

