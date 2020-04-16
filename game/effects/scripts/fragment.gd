extends Node2D



export var velocity_factor := 1.0

var angular_velocity := 0.0
var velocity := Vector2.ZERO



func _ready():
	angular_velocity = rand_range(-PI, PI)

func _process(dt: float):
	rotation += angular_velocity * velocity_factor * dt
	position += velocity * velocity_factor * dt



func configure_polygon(
	vl: PoolVector2Array, 
	uvs: PoolVector2Array, 
	tex: Texture
):
	assert(vl.size() == 3 && uvs.size() == 3)
	
	var center = Vector2.ZERO
	
	for v in vl:
		center += v
	
	center /= 3
	
	for i in range(vl.size()):
		vl[i] = vl[i] - center
	
	position = center
	
	$poly.polygon = vl
	$poly.uv = uvs
	$poly.texture = tex



