tool
extends Node2D


export var color_dark := Color8(0, 159, 37, 255)
export var color_light := Color8(0, 196, 46, 255)

var initial_rotation := 0.0



func _ready():
	set_as_toplevel(true)
	
	initial_rotation = get_parent().rotation
	position = get_parent().position


func _draw():
	var pos = Vector2.ZERO
	var rot = initial_rotation
	
	if Engine.editor_hint:
		rot = get_parent().rotation
	
	var pts = PoolVector2Array()
	pts.push_back(pos)
	
	for r in get_parent().source_code.split("\n"):
		var oldpos = pos
		pos += Vector2(get_parent().STEP, 0).rotated(rot)
		rot += deg2rad(float(r))
		
		pts.push_back(pos)
	
	for i in range(1, pts.size()):
		draw_line(pts[i-1], pts[i], color_dark, 8)
	
	for pt in pts:
		draw_circle(pt, 16, color_light)
