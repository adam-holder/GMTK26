extends Node2D

@export var required_sheep = 0
@export var vertical = false

func _ready():
	$Requirement.text = str(required_sheep)
	Globals.shoop_collected.connect(shoop_check)
	if vertical: $Sprite.play("vertBefore")
	else: $Sprite.play("horizBefore")
		

func shoop_check():
	required_sheep -= 1
	#$Requirement.text = str(required_sheep)
	if required_sheep <= 0:
		Globals.shoop_collected.disconnect(shoop_check)
		if vertical: $Sprite.play("vertAfter")
		else: $Sprite.play("horizAfter")
		$Requirement.queue_free()
		$StaticBody2D.queue_free()
