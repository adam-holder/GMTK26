extends CanvasLayer

@onready var txt = $RichTextLabel
@onready var por = $Portrait

@export var position: SIDE
enum SIDE {TOP, BOTTOM}
@export var speaker: NAME
enum NAME {NONE}
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
	#if speaker == NAME.HILLARY:
		#por.region_rect = Rect2(0,0,48,48)
	#elif speaker == NAME.JESSICA:
		#por.region_rect = Rect2(48,0,48,48)
	#elif speaker == NAME.RICHARD:
		#por.region_rect = Rect2(96,0,48,48)
	#elif speaker == NAME.TERRY:
		#por.region_rect = Rect2(144,0,48,48)
	#elif speaker == NAME.HILLARY2:
		#por.region_rect = Rect2(192,0,48,48)
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
