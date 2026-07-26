extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.won: $Sprite2D.hide()
	if Globals.snoozed == 0: $SnoozeCnt.hide()
	else: $SnoozeCnt.text = "Times Snoozed: " + str(Globals.snoozed)
	if Globals.sheep_counted == 0: $Sheep.hide()
	else: $Sheep.text = "Sheep Counted: " + str(Globals.sheep_counted)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Globals.snoozed += 1
	get_tree().change_scene_to_file('res://Scenes/main.tscn')


func _on_audio_stream_player_2_finished():
	$AudioStreamPlayer.play()
