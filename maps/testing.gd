extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$GUI/ProgressBar.max_value = $player.maxhealth
	$GUI/ProgressBar.value = $player.health


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_soundtrigger_area_entered(area):
	if area.name == 'playerArea':
		$soundtrigger/soundtriggerplayer.stream = preload("res://sounds/temp/pianoback.ogg")
		$soundtrigger/soundtriggerplayer.play()


func _on_death_area_entered(area):
	if area.name == 'playerArea':
		$player.kill()


func _on_hurtArea_area_entered(area):
	if area.name == 'playerArea':
		$player.hurt()
		$GUI/ProgressBar.value = $player.health
