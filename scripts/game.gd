extends Node2D

# CONSTANTS:
const MAX_OBSTACLES : int = 5

# VARIABLES:

# Preload all obstacle scenes
var large_cactus_scene = preload("res://scenes/large_cactus.tscn")
var small_cactus_scene = preload("res://scenes/small_cactus.tscn")
var bird_scene = preload("res://scenes/bird.tscn")

var ground_height : int
var screen_size : Vector2i

# We can't add the bird scene into here as the bird is an animated sprite. 
var obstacles = [large_cactus_scene, small_cactus_scene]
var current_obstacles : Array
var previous_obstacle : Area2D
var bird_heights = [200, 300, 400]

# ON READY VARIABLES:
@onready var ground : StaticBody2D = $Ground

func _ready():
	ground_height = ground.get_node("Sprite2D").texture.get_height()
	screen_size = get_window().size

func _process(delta):
	spawn_obstacles()
	# This will be used for score update and game difficulty
	if !current_obstacles.is_empty():
		for obstacle in current_obstacles:
			if obstacle.position.x < -screen_size.x :
				print("Obstacle position x is: ", obstacle.position.x)
				print("Screen x is: ", screen_size.x)
				despawn_obstacle(obstacle)

func spawn_obstacles():
		if current_obstacles.is_empty() || previous_obstacle.position.x < randi_range(200, 500):
			var new_obstacle = obstacles[randi() % obstacles.size()].instantiate()

			previous_obstacle = new_obstacle

			var new_obstacle_h = new_obstacle.get_node("Sprite2D").texture.get_height()
			var new_obstacle_scale = new_obstacle.get_node("Sprite2D").scale

			# 35 is the offset num of pixels otherwise, obstacle spawns on ground above dino position
			var new_obstacle_y_pos = screen_size.y - ground_height - ((new_obstacle_h * new_obstacle_scale.y) / 2) + 35

			new_obstacle.position = Vector2i(1380, new_obstacle_y_pos)

			add_child(new_obstacle)
		
			current_obstacles.append(new_obstacle)

		# Currently 50% chance to generate bird but this should be tied to game difficulty.
		# if (randi() % 2) == 0:
		# 	var bird = bird_scene.instantiate()
		# 	var bird_x_pos = 1380
		# 	var bird_y_pos = bird_heights[randi() % bird_heights.size()]

		# 	bird.position = Vector2i(bird_x_pos, bird_y_pos)
		
		# 	add_child(bird)

		# 	current_obstacles.append(bird)

func despawn_obstacle(obstacle):
	obstacle.queue_free()
	current_obstacles.erase(obstacle)