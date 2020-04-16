extends Area2D


signal destroyed()




func _ready():
	$shape.shape.radius = $sprite.texture.get_size().x/2


func shot(p):
	for fragment in Fragmenter.fragment($sprite, to_local(p.position)):
		get_parent().add_child(fragment)
	
	emit_signal("destroyed")
	queue_free()
