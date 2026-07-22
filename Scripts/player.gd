extends CharacterBody2D


const speed = 30.0


func _physics_process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")*speed
	move_and_slide()
