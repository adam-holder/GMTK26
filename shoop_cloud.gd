extends Node2D

@export var shoopspeed: float = randf_range(-5, -20)

func _ready() -> void:
	position = position + Vector2(randi_range(-200,0),randi_range(-50,200))

func _process(delta: float) -> void:
	position += Vector2(shoopspeed,0) * delta
	if global_position.x < -300:
		queue_free()
	
