extends Area2D


signal destroyed()


export var bullet_scene: PackedScene



func shot(p):
	for fragment in Fragmenter.fragment($sprite, to_local(p.position)):
		get_parent().add_child(fragment)
	
	visible = false
	emit_signal("destroyed")
	collision_layer = 0
	
	yield(get_tree().create_timer(0.25), "timeout")
	
	shoot(p)
	queue_free()


func shoot(p):
	_hit_targets(p)
	
	p.camera.shake(16, 0.3)
	SfxAudio.play_gunshot()
	
	var pos = $bullet_spawn.global_position
	var dir = Vector2(1, 0).rotated(rotation)
	var bullet = bullet_scene.instance()
	bullet.points = [
		pos,
		pos + dir * 999999
	]
	get_parent().add_child(bullet)



func _hit_targets(p):
	var pos = $bullet_spawn.global_position
	var dir = Vector2(1, 0).rotated(rotation)
	var dss = get_world_2d().direct_space_state
	var hit = dss.intersect_ray(pos, pos + dir * 9999999, [], 0x2, false, true)
	var found = []
	
	if hit.empty():
		return
	
	while not hit.empty():
		hit.collider.shot(p)
		
		found.push_back(hit.collider)
		pos = hit.position
		
		hit = dss.intersect_ray(pos, pos + dir * 9999999, found, 0x2, false, true)
