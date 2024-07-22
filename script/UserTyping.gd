extends Control

signal typing_complete
signal typing_start

var topics = ["typing", "hello", "world", "test"]
var topics_view = []
var typing_text = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	for topic in topics:
		topics_view.append("[color=gray]" + topic + "[/color]")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Typing1.text = topics_view[0]
	$Typing2.text = topics_view[1]
	$Typing3.text = topics_view[2]
	$Typing4.text = topics_view[3]

func _input(event):
	if event is InputEventKey:
		var typed = PackedByteArray([event.unicode]).get_string_from_utf8()
		if event.is_pressed() and not event.is_echo() and typed != "":
			typing_text += typed

			var hit = false
			for topic in topics:
				if check_typing(typing_text ,topic):
					topics_view[topics.find(topic)] = "[color=red]" + typing_text + "[/color][color=gray]" + topic.erase(0, typing_text.length()) + "[/color]"

					if typing_text == topic:
						print(typing_text)
						print("complete")

					hit = true
				else:
					topics_view[topics.find(topic)] = "[color=gray]" + topic + "[/color]"

			if not hit:
				typing_text = ""
				for topic in topics:
					if check_typing(typed ,topic):
						typing_text = typed
						topics_view[topics.find(topic)] = "[color=red]" + typing_text + "[/color][color=gray]" + topic.erase(0, typing_text.length()) + "[/color]"


func check_typing(text, topic):
	if topic.length() < text.length():
		return false

	if topic.begins_with(text):
		return true

	return false


func set_topic(new_topic):
	emit_signal("typing_start")
