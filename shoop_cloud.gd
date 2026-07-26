extends Node2D

@export var shoopspeed: float = randf_range(-5, -20)

func _ready() -> void:
	position = position + Vector2(randi_range(-200,0),randi_range(-50,200))
	if randf() < .01:
		modulate = Color(1.0, 0.766, 0.73, 1.0)
	if randf() < .005:
		modulate = Color(1.0, 0.89, 0.61, 1.0)
	if randf() < .3:
		$Sprite2D.flip_h = true
	var scal = randf_range(1.0,2.0)
	scale = Vector2(scal,scal)

func _process(delta: float) -> void:
	position += Vector2(shoopspeed,0) * delta
	if global_position.x < -300:
		queue_free()
	
