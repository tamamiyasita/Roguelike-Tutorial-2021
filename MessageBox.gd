extends Control



var massage:PoolStringArray = []
var log_text:PoolStringArray = []

var massage_index := 0
var finished := false

onready var text_box:RichTextLabel = $RichTextLabel
onready var log_box:RichTextLabel = $TextureRect/Log
onready var log_bg:TextureRect = $TextureRect
var ind = 1
	
	
func _ready() -> void:
	load_massage()
	set_process(false)
	
func _process(delta: float) -> void:
	if massage.size() > 0:
		load_massage()
	set_process(false)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('log'):
		if !log_bg.visible:
			log_bg.show()
		else:
			log_bg.hide()


func get_massage(text):
	massage.insert(0, " "+str(text)+"\n")
	log_box.bbcode_text += text+"\n"
	
	set_process(true)

func load_massage() -> void:
	if 0 < massage.size():
		var tex = ""
		for t in range(massage.size()):
			tex += massage[t]
		
		text_box.text = tex





func _on_TextureButton_pressed():
	log_bg.visible = !log_bg.visible
