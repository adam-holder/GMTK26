extends CanvasLayer

##Number of seconds the timer starts at
@export var timer_start: float = 30
##Current seconds left in the timer
var timer = timer_start
var timer_ended = false

func _ready():
	#This is so we don't need to worry about hiding/showing the HUD in main while editing
	show()
	$TempEnd.hide()
	
	Globals.shoop_collected.connect(shoop_collected)

func _process(delta):
	if timer_ended: return
	
	timer -= delta
	#When the timer is up, emit a signal and
	if timer <= 0:
		Globals.timeup.emit()
		print("Timeup emitted!")
		timer_ended = true
		get_tree().change_scene_to_file('res://Scenes/title.tscn')
		$Remaining.hide()
		$Sheep.hide()
		$TempEnd.show()
	#If there's less than 10 seconds, show the first decimal
	elif timer <= 10: $Remaining.text = "Time Remaining: " + str(timer).left(3)
	#Else, display seconds as an int (rounded down)
	else: $Remaining.text = "Time Remaining: " + str(timer).split(".")[0]

##Resets the HUD
func reset():
	Globals.reset.emit()
	timer = timer_start
	timer_ended = false
	Globals.shoop_count = 0
	$Sheep.text = "Sheep Collected: " + str(Globals.shoop_count)
	$TempEnd.hide()
	$Remaining.show()
	$Sheep.show()

##Happens when a shoop is collected
func shoop_collected():
	timer += Globals.shoop_mod
	Globals.shoop_count += 1
	$Sheep.text = "Sheep Collected: " + str(Globals.shoop_count)
