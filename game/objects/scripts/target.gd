extends Area2D



signal destroyed()



func shot(p):
	for fragment in Fragmenter.fragment($sprite, to_local(p.position)):
		get_parent().add_child(fragment)
	
	emit_signal("destroyed")
	queue_free()
