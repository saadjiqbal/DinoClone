extends Node2D

# CONSTANTS:
const MAX_OBSTACLES : int = 5
const OBSTACLE_SPAWN_POS_X : int = 1380
const SCORE_INCREMENT : float = 0.05
const TIMER_LOWER_LIMIT : float = 0.5
const TIMER_UPPER_LIMIT : float = 2.0

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

var spawn_timer : Timer
var spawn_delay : float
var timer_lower_limit : float = 0.5
var timer_upper_limit : float = 2.0

var spawn_timer_created : bool = false

# ON READY VARIABLES:
@onready var ground : StaticBody2D = $Ground
@onready var hud : CanvasLayer = $HUD

func _ready() -> void:
	ground_height = ground.get_node("Sprite2D").texture.get_height()
	screen_size = get_window().size

	spawn_timer_controller()

func _process(_delta) -> void:
	score_handler()
	spawn_timer_controller()
	despawn_obstacle()

func spawn_timer_controller() -> void:
	if !spawn_timer_created:
		spawn_timer_created = true
		
		spawn_timer = Timer.new()

		add_child(spawn_timer)

		
		spawn_timer.one_shot = false
		spawn_timer.autostart = true

		# Timers by default in Godot start with a 1 sec value so we don't have to explicitly
		# set the wait_time before starting
		spawn_timer.start()

		spawn_timer.connect("timeout", _on_spawn_timer_timeout)
	else:
		spawn_timer.wait_time = randf_range(TIMER_LOWER_LIMIT, TIMER_UPPER_LIMIT)

func score_handler() -> void:
	score += SCORE_INCREMENT
	hud.get_node("ScoreLabel").text = "SCORE: " + str(int(score))

func _on_spawn_timer_timeout() -> void:
	spawn_obstacles()

func spawn_obstacles() -> void:
	var new_obstacle = obstacles[randi() % obstacles.size()].instantiate()

	var new_obstacle_h = new_obstacle.get_node("Sprite2D").texture.get_height()
	var new_obstacle_scale = new_obstacle.get_node("Sprite2D").scale

	# 35 is the offset num of pixels otherwise, obstacle spawns on ground above dino position
	var new_obstacle_y_pos = screen_size.y - ground_height - ((new_obstacle_h * new_obstacle_scale.y) / 2) + 35

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
	obstacle.body_entered.connect(obstacle_hit)
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