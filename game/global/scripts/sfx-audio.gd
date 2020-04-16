extends Node


const Gunshots = [
	preload("res://assets/sfx/gunshot-0.wav"),
	preload("res://assets/sfx/gunshot-1.wav"),
	preload("res://assets/sfx/gunshot-2.wav"),
	preload("res://assets/sfx/gunshot-3.wav"),
	preload("res://assets/sfx/gunshot-4.wav"),
	preload("res://assets/sfx/gunshot-5.wav"),
	preload("res://assets/sfx/gunshot-6.wav"),
	preload("res://assets/sfx/gunshot-7.wav"),
]

const TargetBreaks = [
	preload("res://assets/sfx/target-breaking-0.wav"),
	preload("res://assets/sfx/target-breaking-1.wav"),
	preload("res://assets/sfx/target-breaking-2.wav")
]



func play_sfx(sfx: AudioStream):
	var selected: AudioStreamPlayer
	var factor := 0.0
	
	for i in range(get_child_count()):
		var asp = get_child(i) as AudioStreamPlayer
		
		if not asp.playing:
			asp.stream = sfx
			asp.play()
			return
		
		if asp.get_playback_position() >= asp.stream.get_length():
			asp.stream = sfx
			asp.play()
			return
		
		var f = asp.get_playback_position() / asp.stream.get_length()
		if f > factor:
			selected = asp
	
	selected.stream = sfx
	selected.play()

func play_gunshot():
	play_sfx(Gunshots[randi() % Gunshots.size()])

func play_target_breaking():
	play_sfx(TargetBreaks[randi() % TargetBreaks.size()])
