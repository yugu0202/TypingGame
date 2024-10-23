extends Control
## ユーザーが入力するためのコントロール

## シグナル: 入力された文字列がトピックと一致した
signal typing_complete(id: int)

## [Topic]のリスト
var topics: Array

## 子ノードのリスト
var children: Array

## 入力された文字列
var typing_text: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var _topics = [[1, "typing"], [2, "hello"], [3, "world"], [4, "easy"]]
	children = get_children()
	first_topics(_topics)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	for i in children.size():
		children[i].text = topics[i].view


# Called when the node receives input event.
func _input(event) -> void:
	if event is InputEventKey:
		var typed = PackedByteArray([event.unicode]).get_string_from_utf8()
		if event.is_pressed() and not event.is_echo() and typed != "":
			if not _on_typing(typed):
				# 間違っていた場合のエフェクト処理
				var tween = create_tween()
				tween.tween_property(self, "modulate", Color.RED, 0.2)
				tween.tween_property(self, "modulate", Color.WHITE, 0.1)


## 入力された一文字を、トピックに対して処理する[br]
## トピックが完全に一致した場合はシグナルを送信する[br]
##
## [param typed] 入力された一文字[br]
##
## if [code]false[/code] 入力した文字がなににも一致しなかった[br]
func _on_typing(typed: String) -> bool:
	typing_text += typed

	var hit = false
	for topic in topics:
		hit = topic.process_input(typing_text) or hit
		if topic.is_complete(typing_text):
			reset_all_highlight()
			print("complete")
			print(topic.id, topic.topic)
			typing_complete.emit(topic.id)
			return true

	if hit:
		return true

	typing_text = typed
	for topic in topics:
		hit = topic.process_input(typing_text) or hit

	if hit:
		return true

	typing_text = ""

	return false


## 管理しているすべてのトピックのハイライトをリセットする
func reset_all_highlight() -> void:
	topics.map(func (topic): topic.reset_highlight())


## トピックをIDで更新する[br]
##
## [param new_topic] 新しいトピック[br]
## [param id] トピックのID[br]
func set_topic_by_id(new_topic: String, id: int) -> void:
	for topic in topics:
		if topic.id == id:
			topic.set_topic(new_topic)
			return


## 最初のトピックを設定する
##
## [param initial_topics] 初期のトピックリスト
func first_topics(initial_topics: Array) -> void:
	topics = initial_topics.map(func (x): return Topic.new(x[0], x[1]))
