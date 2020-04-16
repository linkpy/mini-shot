extends Area2D


export var camera_path: NodePath
onready var camera = get_node(camera_path)


func _physics_process(dt: float):
	position = get_global_mouse_position()

func _input(ev: InputEvent):
	if ev.is_action_pressed("fire") and not $anim.is_playing():
		$anim.play("fire")
		camera.shake(16, 0.3)
		SfxAudio.play_gunshot()
		
		for area in get_overlapping_areas():
			if area.has_method("shot"):
				area.shot(self)



func _on_area_entered(area):
	if area.has_method("aim_entered"):
		area.aim_entered(self)

func _on_area_exited(area):
	if area.has_method("aim_exited"):
		area.aim_exited(self)
