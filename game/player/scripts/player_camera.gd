extends Camera2D


export var shaking := 0.0



func _process(_dt: float):
	position = Vector2(shaking, 0).rotated(rand_range(0, 2*PI))
	
	var vs = get_viewport_rect().size
	$background.region_rect = Rect2(
		global_position - vs/2,
		vs * 2
	)



func shake(v: float, d: float):
	$tween.reset_all()
	$tween.interpolate_property(
		self, "shaking", 
		v, 0, d, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	$tween.start()
