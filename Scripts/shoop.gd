extends Node2D

var start_pos

func _ready():
	start_pos = position
	Globals.reset.connect(reset)
	Globals.timeup.connect(timeup)

func _on_area_2d_body_entered(_body):
	#position += Vector2(randi_range(50,100),0) .rotated(randf_range(0,2*PI))
	Globals.shoop_collected.emit()
	if randf()>.5:
		$HighBaa.play()
	else:
		$LowBaa.play()
	hide()

func reset():
	position = start_pos
	show()

func timeup(): hide()


func _on_baa_finished():
	queue_free()
