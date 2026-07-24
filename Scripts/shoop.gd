extends Node2D


func _on_area_2d_body_entered(_body):
	position += Vector2(randi_range(50,100),0) .rotated(randf_range(0,2*PI))
	Globals.shoop_collected.emit()
	#queue_free()
