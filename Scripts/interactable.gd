extends Area2D

signal dialog_closed
var index = 0
var contents: Array
var active = false
@export var displacement: Node2D
@export var one_shot: bool = true
var happened = false
func _ready():
	if displacement != null: Reparent(displacement)
	else: Reparent(self)
	

func _process(_delta):
	if Input.is_action_just_pressed("interact"): Advance()

func Advance():
	if one_shot && happened: return
	if contents.size() == 0: return
	if not active: return

	if index >= contents.size():
		for entry in contents: entry.hide()
		index = 0
		get_tree().paused = false
		happened = true
		dialog_closed.emit()
	elif index == 0:
		get_tree().paused = true
		if !contents[index].visible:
			contents[index].show()
		elif !contents[index].is_complete():
			#print("not done")
			contents[index].set_complete()
		else:
			index += 1
			contents[index-1].hide()
			if index < contents.size():
				contents[index].show()
			else: Advance()
		show()
	else:
		if !contents[index].visible:
			contents[index].show()
		elif !contents[index].is_complete():
			#print("not done")
			contents[index].set_complete()
		else:
			contents[index].hide()
			index += 1
			if index < contents.size():
				contents[index].show()
			else: Advance()


func Reparent(target :Node2D):
	contents = target.get_children()
	
	var removal: Array
	for thing in contents:
		if thing is not CanvasLayer:
			removal.append(thing)
	for thing in removal: contents.erase(thing)

func _on_body_entered(body):
	active = true
	#body.ShowSpace(true)


func _on_body_exited(body):
	active = false
	#body.ShowSpace(false)

func dialogue_mode():
	active = true
