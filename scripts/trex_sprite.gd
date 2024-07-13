extends AnimatedSprite2D

# Test trex and trex_shadow run animations

# I split the sprites into two different Sprite2D scenes so that when I add the
# jump animation, the shadow can move down and to the left as the trex moves up

# I saved them as scenes here since I don't have access to the player scene
# and wouldn't want to mess with it if I did, but feel free to copy and paste
# them into the player scene instead of instantiating them since they don't
# need their own script or anything like that. This is just to test that
# the animation is synced

func _ready():
	play()
	$TrexShadowSprite.play()
