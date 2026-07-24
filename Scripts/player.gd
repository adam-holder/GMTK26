extends CharacterBody2D

@onready var body = $Body

const speed = 50.0

func _ready():
	pass

func _physics_process(_delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")*speed
	move_and_slide()
	if velocity.length() < .01:
		body.stop()
	elif abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			body.play("walk_right")
		else:
			body.play("walk_left")
	else:
		if velocity.y > 0:
			body.play("walk_down")
		else:
			body.play("walk_up")
