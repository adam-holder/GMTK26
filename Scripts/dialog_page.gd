extends CanvasLayer

@onready var txt = $RichTextLabel
@onready var por = $Portrait

@export var position: SIDE
enum SIDE {TOP, BOTTOM}
@export var speaker: NAME
enum NAME {NONE,HERO_SLEEP,HERO_HAPPY,HERO_SAD,YUME}
@export var vertical_offset: int = -500
@export var horizontal_offset: int = 0
@export_multiline var text: String

var delta_sum = 0.0
var complete = false

func set_portrait_mode():
	txt = $RichTextLabelP
	$RichTextLabelP.show()
	$RichTextLabel.hide()
	set_portrait()
	por.show()

func _ready():
	if speaker != NAME.NONE:
		set_portrait_mode()
	else:
		por.hide()
		$RichTextLabelP.hide()
	hide()
	match position:
		SIDE.TOP:
			for thing in get_children():
				thing.position += Vector2(horizontal_offset, vertical_offset)
		SIDE.BOTTOM:
			$ColorRect2.queue_free()
	txt.text = text
	txt.visible_characters=0

func set_portrait():
	if speaker == NAME.HERO_SLEEP:
		por.play("hero_sleep")
	elif speaker == NAME.HERO_HAPPY:
		por.play("hero_happy")
	elif speaker == NAME.HERO_SAD:
		por.play("hero_sad")
	elif speaker == NAME.YUME:
		por.play("yume")
	pass
	
func _process(delta):
	if visible and complete and !_is_special():
		$Title/Space.show()
		$ColorRect/Space.show()
	if visible and !complete and !_is_special():
		delta_sum += delta
		txt.visible_characters = int(delta_sum*30.)
		if txt.visible_characters >= txt.text.length():
			complete = true

func set_complete():
	if !_is_special():
		txt.visible_characters = txt.text.length()
		complete = true
	

func is_complete():
	return complete


func _on_visibility_changed():
	if !visible:
		delta_sum = 0.0
		complete = false

func _is_special():
	return false #(speaker == NAME.CHEERS or speaker == NAME.ENDCHOICE)
