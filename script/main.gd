extends Node2D

var typing_texts = ["typing", "hello", "world", "test", "godot", "input"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_typing_form_typing_complete(id: int) -> void:
	var exists_topics: Array = $TypingForm.topics.map(func (x): return x.topic)
	print(exists_topics)
	var choice_list = typing_texts.filter(func (x): return not exists_topics.has(x))
	print(choice_list)
	$TypingForm.set_topic_by_id(choice_list[randi() % choice_list.size()], id)
