
class_name Topic

var id: int
var topic: String
var view: String

func _init(new_id: int, new_topic: String) -> void:
	self.id = new_id
	self.topic = new_topic
	self.view = "[color=gray]%s[/color]" % new_topic


func check_typing(check_text: String) -> bool:
	if self.topic.length() < check_text.length():
		return false

	if self.topic.begins_with(check_text):
		return true

	return false


func reset_highlight() -> void:
	self.view = "[color=gray]%s[/color]" % self.topic


func highlight(text: String) -> bool:
	if self.check_typing(text):
		self.view = "[color=green]%s[/color][color=gray]%s[/color]" % [text, self.topic.erase(0, text.length())]
		return true
	else:
		self.reset_highlight()
	
	return false


func is_complete(text) -> bool:
	return self.topic == text


func set_topic(new_topic: String) -> void:
	self.topic = new_topic
	self.view = "[color=gray]%s[/color]" % new_topic
