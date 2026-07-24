extends CanvasLayer

##Number of seconds the timer starts at
@export var timer_start: float = 30
##Current seconds left in the timer
var timer = timer_start
##Signal emitted when the timer hits 0
signal timeup
var timer_ended = false

func _ready():
	#This is so we don't need to worry about hiding/showing the HUD in main while editing
	show()

func _process(delta):
	if timer_ended: return
	
	timer -= delta
	#When the timer is up, emit a signal and
	if timer <= 0:
		timeup.emit()
		print("Timeup emitted!")
		timer_ended = true
	#If there's less than 10 seconds, show the first decimal
	elif timer <= 10: $Remaining.text = "Time Remaining: " + str(timer).left(3)
	#Else, display seconds as an int (rounded down)
	else: $Remaining.text = "Time Remaining: " + str(timer).split(".")[0]

## Resets the timer functionality in the HUD
func reset():
	timer = timer_start
	timer_ended = false
