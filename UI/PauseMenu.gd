extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _on_Resume_pressed():
	self.is_paused = false
	$UISound.stream = preload("res://sounds/temp/413690__splatfreesound__click.wav")
	$UISound.play()


func _on_Quit_pressed():
	$UISound.stream = preload("res://sounds/temp/413690__splatfreesound__click.wav")
	$UISound.play()
	get_tree().quit()
