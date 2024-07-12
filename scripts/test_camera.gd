extends Camera2D

var move_timer: int = 0

# "Pixel" perfect camera motion that's hard to look at
#func _on_timer_timeout():
	#move_timer += 1
	#if move_timer == 8:
		#position.x += 10
		#move_timer = 0

# Smooth camera motion
func _process(delta):
	position.x += 30 * delta
