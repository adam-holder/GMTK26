extends Node

##The number of seconds the timer increases by when collecting sheep
var shoop_mod = 1
var shoop_count = 0
var won = false

@warning_ignore_start("unused_signal")
##Signal emitted when a shoop is collected
signal shoop_collected
##Signal emitted when the timer hits 0
signal timeup
##Signal emitted when restarting the game
signal reset

func _ready():
	reset.connect(reset_globals)

func reset_globals():
	shoop_count = 0
