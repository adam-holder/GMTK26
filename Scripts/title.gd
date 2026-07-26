extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.won: $Sprite2D.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file('res://Scenes/main.tscn')


func _on_audio_stream_player_2_finished():
	$AudioStreamPlayer.play()
