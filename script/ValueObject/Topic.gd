
class_name Topic
## トピックの情報を保持するクラス
##
## トピックのIDと内容を保持し、
## BBCodeで表示するための文字列を生成する
##

## トピックのID
var id: int

## トピックの内容
var topic: String

## BBCodeで表示するトピックの内容
var view: String

func _init(new_id: int, new_topic: String) -> void:
	self.id = new_id
	self.topic = new_topic
	self.view = "[color=gray]%s[/color]" % new_topic


## 入力された文字列がトピックの先頭に一致するかを確認する[br]
##
## [param check_text] 入力された文字列[br]
##
## if [code]true[/code] トピックの先頭に一致する[br]
func _check_typing(check_text: String) -> bool:
	if self.topic.length() < check_text.length():
		return false

	if self.topic.begins_with(check_text):
		return true

	return false


## ハイライトをリセットする
func reset_highlight() -> void:
	self.view = "[color=gray]%s[/color]" % self.topic


## 入力された文字列がトピックの先頭に一致するかを確認し、[br]
## 一致していればハイライトをつける[br]
## 一致していなければハイライトをリセットする[br]
##
## [param text] 入力された文字列[br]
##
## if [code]true[/code] トピックの先頭に一致する[br]
func process_input(text: String) -> bool:
	var check := self._check_typing(text)

	if check:
		self.view = "[color=green]%s[/color][color=gray]%s[/color]" % [text, self.topic.erase(0, text.length())]
	else:
		self.reset_highlight()
	
	return check


## 入力された文字列がトピックと完全に一致しているかを確認する[br]
##
## [param text] 入力された文字列[br]
##
## if [code]true[/code] 入力された文字列がトピックと完全一致している
func is_complete(text: String) -> bool:
	return self.topic == text


## 新しいトピックを設定する[br]
##
## [param new_topic] 新しいトピック
func set_topic(new_topic: String) -> void:
	self.topic = new_topic
	self.view = "[color=gray]%s[/color]" % new_topic
