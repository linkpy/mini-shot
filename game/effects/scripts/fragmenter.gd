class_name Fragmenter
extends Node


const Fragment = preload("../fragment.tscn")


static func fragment(spr: Sprite, break_point: Vector2, pt_count := 16) -> Array:
	var ss = spr.texture.get_size() * spr.scale
	var res = []
	var pts = PoolVector2Array()
	
	break_point = Vector2(
		clamp(break_point.x, -ss.x/2, ss.x/2),
		clamp(break_point.y, -ss.y/2, ss.y/2)
	)
	
	pts.push_back(break_point)
	pts.push_back(Vector2(-ss.x, -ss.y) / 2)
	pts.push_back(Vector2( ss.x, -ss.y) / 2)
	pts.push_back(Vector2( ss.x,  ss.y) / 2)
	pts.push_back(Vector2(-ss.x,  ss.y) / 2)
	
	for _i in range(pt_count):
		pts.push_back(Vector2(
			rand_range(-ss.x/2, ss.x/2),
			rand_range(-ss.y/2, ss.y/2)
		))
	
	var triangles = Geometry.triangulate_delaunay_2d(pts)
	assert(triangles.size() > 0)
	
	for i in range(triangles.size() / 3):
		var j = i * 3
		
		var vl = PoolVector2Array()
		vl.push_back(pts[triangles[j+0]])
		vl.push_back(pts[triangles[j+1]])
		vl.push_back(pts[triangles[j+2]])
		
		var uvs = PoolVector2Array()
		uvs.push_back(vl[0].rotated(-spr.rotation) + ss/2)
		uvs.push_back(vl[1].rotated(-spr.rotation) + ss/2)
		uvs.push_back(vl[2].rotated(-spr.rotation) + ss/2)
		
		var frag = Fragment.instance()
		frag.configure_polygon(vl, uvs, spr.texture)
		frag.velocity = (frag.position - break_point) * 4
		frag.position += spr.global_position
		res.push_back(frag)
	
	return res
