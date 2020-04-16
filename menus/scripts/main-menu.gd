extends Control




func _on_play_destroyed():
	yield(get_tree().create_timer(0.6), "timeout")

func _on_exit_destroyed():
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().quit()

func _on_settings_destroyed():
	yield(get_tree().create_timer(0.6), "timeout")
