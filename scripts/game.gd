extends Node2D

# CONSTANTS:
const MAX_OBSTACLES : int = 5
const OBSTACLE_SPAWN_POS_X : int = 1380
const SCORE_INCREMENT : float = 0.1

# VARIABLES:

# Preload all obstacle scenes
var large_cactus_scene = preload("res://scenes/large_cactus.tscn")
var small_cactus_scene = preload("res://scenes/small_cactus.tscn")
var bird_scene = preload("res://scenes/bird.tscn")

var ground_height : int
var screen_size : Vector2i

# We can't add the bird scene into obstacles array as the bird is an animated sprite and has a different height. 
var obstacles = [large_cactus_scene, small_cactus_scene]
var current_obstacles : Array
var previous_obstacle : Area2D
var bird_heights = [200, 300, 400]

var score : float

# ON READY VARIABLES:
@onready var ground : StaticBody2D = $Ground
@onready var hud : CanvasLayer = $HUD

func _ready() -> void:
	ground_height = ground.get_node("Sprite2D").texture.get_height()
	screen_size = get_window().size

func _process(_delta) -> void:
	score_handler()
	spawn_obstacles()
	despawn_obstacle()

func score_handler() -> void:
	score += SCORE_INCREMENT
	hud.get_node("ScoreLabel").text = "SCORE: " + str(score)

func spawn_obstacles() -> void:
	if current_obstacles.is_empty() || previous_obstacle.position.x < randi_range(200, 500):
		var new_obstacle = obstacles[randi() % obstacles.size()].instantiate()

		previous_obstacle = new_obstacle

		var new_obstacle_h = new_obstacle.get_node("Sprite2D").texture.get_height()
		var new_obstacle_scale = new_obstacle.get_node("Sprite2D").scale

		# 35 is the offset num of pixels otherwise, obstacle spawns on ground above dino position
		var new_obstacle_y_pos = screen_size.y - ground_height - ((new_obstacle_h * new_obstacle_scale.y) / 2) + 35

		# I think this is a typo
		add_osbtacle(new_obstacle, new_obstacle_y_pos)

	# Currently 50% chance to generate bird but this should be tied to game difficulty.
	# if (randi() % 2) == 0:
	# 	var bird = bird_scene.instantiate()
	# 	var bird_x_pos = 1380
	# 	var bird_y_pos = bird_heights[randi() % bird_heights.size()]

	# 	bird.position = Vector2i(bird_x_pos, bird_y_pos)
	
	# 	add_child(bird)

	# 	current_obstacles.append(bird)

func add_osbtacle(obstacle, y_pos) -> void:
	obstacle.position = Vector2i(OBSTACLE_SPAWN_POS_X, y_pos)
	add_child(obstacle)
	current_obstacles.append(obstacle)

func despawn_obstacle() -> void:
	if !current_obstacles.is_empty():
		for obstacle in current_obstacles:
			if obstacle.position.x < -screen_size.x:
				obstacle.queue_free()
				current_obstacles.erase(obstacle)

func obstacle_hit(body) -> void:
	# This is probably really bad as if we rename Player to something else, our collision would stop working.
	if body.name == "Player":
		game_over()

func game_over() -> void:
	get_tree().paused = true
