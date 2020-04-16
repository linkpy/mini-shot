tool
extends Area2D


signal destroyed()



const STEP = 324

export(String, MULTILINE) var source_code setget set_source_code

var _rotations := []
var _rot_index := 0



func _ready():
	if Engine.editor_hint:
		return
	
	$sprite.rotation = rotation
	rotation = 0
	
	for r in source_code.split("\n"):
		_rotations.push_back(float(r))



func set_source_code(v):
	source_code = v
	$predictor.update()


func shot(p):
	if _rot_index >= _rotations.size():
		for fragment in Fragmenter.fragment($sprite, to_local(p.position)):
			get_parent().add_child(fragment)
		
		emit_signal("destroyed")
		queue_free()
		return
	
	var dir = Vector2(STEP, 0).rotated($sprite.rotation)
	$tween.reset_all()
	$tween.interpolate_property(
		self, "position", 
		position, position + dir, 
		0.3, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	$tween.interpolate_property(
		$sprite, "rotation",
		$sprite.rotation, $sprite.rotation + deg2rad(_rotations[_rot_index]),
		0.15, Tween.TRANS_QUAD, Tween.EASE_OUT,
		0.15
	)
	$tween.start()
	
	_rot_index += 1

