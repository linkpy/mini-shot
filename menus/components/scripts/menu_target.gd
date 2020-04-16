extends Area2D



signal destroyed()


export var respawnable := true


func shot(p):
	for fragment in Fragmenter.fragment($sprite, to_local(p.position)):
		get_parent().add_child(fragment)
	
	SfxAudio.play_target_breaking()
	emit_signal("destroyed")
	
	if respawnable:
		visible = false
		collision_layer = 0
	else:
		queue_free()

func respawn():
	visible = true
	collision_layer = 0x2
