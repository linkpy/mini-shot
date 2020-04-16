tool
extends Area2D


signal shot()
signal ammo_depleated()


export var mouse_sensitivity := Vector2.ONE
export var limit_left   := -10000000 setget set_limit_left
export var limit_top    := -10000000 setget set_limit_top
export var limit_right  :=  10000000 setget set_limit_right
export var limit_bottom :=  10000000 setget set_limit_bottom
export var ammo_count   := 999

onready var camera := $camera

var is_moving := true



func set_limit_left(v):
	limit_left = v
	update()

func set_limit_top(v):
	limit_top = v
	update()

func set_limit_right(v):
	limit_right = v
	update()

func set_limit_bottom(v):
	limit_bottom = v
	update()



func _draw():
	if not Engine.editor_hint:
		return
	
	var vhs = get_viewport_rect().size / 2
	
	var vrect = Rect2(
		limit_left - position.x,
		limit_top - position.y,
		limit_right - limit_left,
		limit_bottom - limit_top
	)
	
	var arect = Rect2(
		vrect.position + vhs,
		vrect.size - vhs * 2
	)
	
	draw_rect(vrect, Color.red, false, 8)
	draw_rect(arect, Color.lime, false, 8)

func _input(ev: InputEvent):
	if Engine.editor_hint:
		return
	
	if ev is InputEventMouseMotion and is_moving:
		position += ev.relative * mouse_sensitivity
		_clamp_position()
	
	if ev.is_action_pressed("fire") and not $anim.is_playing() and is_moving:
		if ammo_count <= 0:
			emit_signal("ammo_depleated")
		
		else:
			$anim.play("fire")
			camera.shake(16, 0.3)
			ammo_count -= 1
			emit_signal("shot")
			
			for area in get_overlapping_areas():
				if area.has_method("shot"):
					area.shot(self)



func _clamp_position():
	var vhs = get_viewport_rect().size / 2
	
	position = Vector2( 
		clamp(
			position.x, 
			limit_left + vhs.x, limit_right - vhs.x
		), 
		clamp(
			position.y,
			limit_top + vhs.y, limit_bottom - vhs.y
		)
	)



func _on_area_entered(area):
	if Engine.editor_hint:
		return
	
	if area.has_method("aim_entered"):
		area.aim_entered(self)

func _on_area_exited(area):
	if Engine.editor_hint:
		return
	
	if area.has_method("aim_exited"):
		area.aim_exited(self)
