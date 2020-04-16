extends Node2D


signal won()
signal lost()


export var next_level: PackedScene

onready var _gui = $gui_layer/ingame_gui
onready var _black = $gui_layer/black
onready var _player = $player_aim

var target_count := 0



func _ready():
	randomize()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_gui.set_ammo_count(_player.ammo_count)
	
	for target in get_tree().get_nodes_in_group("target"):
		target_count += 1
		target.connect("destroyed", self, "_on_target_destroyed")
	
	_gui.set_target_count(target_count)
	_black.skip("fade-out")
	_black.skip("slide-in")
	_black.play("slide-out")

func _process(_delta):
	update()

func _input(ev: InputEvent):
	if ev.is_action_pressed("pause"):
		get_tree().quit()
	
	if ev.is_action("restart"):
		get_tree().reload_current_scene()
	
	if ev is InputEventMouseButton and not _player.is_moving and not _black.is_playing():
		if target_count == 0:
			get_tree().change_scene_to(next_level)
		else:
			get_tree().reload_current_scene()
	
	if ev.is_action_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen



func _on_player_aim_shot():
	_gui.set_ammo_count(_player.ammo_count)
	SfxAudio.play_gunshot()

func _on_player_aim_ammo_depleated():
	emit_signal("lost")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_player.is_moving = false
	_black.lose()

func _on_target_destroyed():
	target_count -= 1
	_gui.set_target_count(target_count)
	SfxAudio.play_target_breaking()
	
	if target_count == 0:
		emit_signal("won")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		_player.is_moving = false
		_black.win()


