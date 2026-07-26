extends CharacterBody2D

@onready var shoopCloud: PackedScene = preload("res://Scenes/shoop_cloud.tscn")
@onready var body = $Body
var start_pos

const speed = 50.0

func _ready():
	start_pos = position
	Globals.reset.connect(reset)
	Globals.timeup.connect(timeup)

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

	
	

func reset():
	position = start_pos
	show()

func timeup(): hide()


func _on_shoop_cloud_timer_timeout() -> void:
	var shoop_instance = shoopCloud.instantiate()
	shoop_instance.global_position = global_position
	shoop_instance.z_index = -21
	$"../ShoopClouds".add_child(shoop_instance)
