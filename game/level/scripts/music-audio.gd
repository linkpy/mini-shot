extends Node


const Musics = [
	preload("res://assets/musics/A_Slow_Dream.ogg"),
	preload("res://assets/musics/At_Depth.ogg"),
	preload("res://assets/musics/Cast_of_Pods.ogg"),
	preload("res://assets/musics/Mind_And_Eye_Journey.ogg"),
	preload("res://assets/musics/Patent_Doll.ogg"),
	preload("res://assets/musics/Sea_Space.ogg"),
	preload("res://assets/musics/Waterfall.ogg"),
]


func _ready():
	_on_player_finished()

func _on_player_finished():
	var old = $player.stream
	
	while $player.stream == old:
		$player.stream = Musics[randi() % Musics.size()]
	
	$player.play()
