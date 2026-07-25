extends Node2D

@export var required_sheep = 0

func _ready():
	$Requirement.text = str(required_sheep)
	Globals.shoop_collected.connect(shoop_check)

func shoop_check():
	required_sheep -= 1
	#$Requirement.text = str(required_sheep)
	if required_sheep <= 0:
		Globals.shoop_collected.disconnect(shoop_check)
		$Clouds.queue_free()
		$Requirement.queue_free()
		$StaticBody2D.queue_free()
