extends Control

signal typing_complete(id: int)
signal typing_start

var topics: Array
var children: Array
var typing_text = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var _topics = [[1, "typing"], [2, "hello"], [3, "world"], [4, "easy"]]
	children = get_children()
	init_topics(_topics)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	for i in children.size():
		children[i].text = topics[i].view


func _input(event) -> void:
	if event is InputEventKey:
		var typed = PackedByteArray([event.unicode]).get_string_from_utf8()
		if event.is_pressed() and not event.is_echo() and typed != "":
			if not on_typing(typed):
				var tween = create_tween()
				tween.tween_property(self, "modulate", Color.RED, 0.2)
				tween.tween_property(self, "modulate", Color.WHITE, 0.1)


func on_typing(typed: String) -> bool:
	typing_text += typed

	var hit = false
	for topic in topics:
		hit = hit or topic.highlight(typing_text)
		if topic.is_complete(typing_text):
			reset_highlight()
			print("complete")
			print(topic.id, topic.topic)
			emit_signal("typing_complete", topic.id)
			return true

	if hit: return true

	typing_text = typed
	for topic in topics:
		hit = hit or topic.highlight(typing_text)

	if hit: return true

	typing_text = ""

	return false


func check_typing(text, topic):
	if topic.length() < text.length():
		return false

	if topic.begins_with(text):
		return true

	return false


func reset_highlight():
	for topic in topics:
		topic.reset_highlight()


func set_topic(new_topic, complete_id):
	for i in range(0, topics.size()):
		if topics[i].id == complete_id:
			topics[i].set_topic(new_topic)
			return


func init_topics(initial_topics: Array):
	topics = initial_topics.map(func (x): return Topic.new(x[0], x[1]))
