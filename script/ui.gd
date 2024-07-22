extends Control

var time = 0.0
var in_game = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_game:
		time += delta
	$Time.text = "%.3f" % $GameTimer.time_left

func _on_typing_form_typing_complete(correct_count, incorrect_count):
	in_game = false
	$GameTimer.stop()
	$Time.visible = false
	$Result/CompleteText.text = "Clear\nTime: %.3f\nCorrect: %d Incorrect: %d" % [time, correct_count, incorrect_count]
	$Result.visible = true

func _on_typing_form_typing_start():
	in_game = true

func _on_game_timer_timeout():
	in_game = false
	$Time.visible = false
	$Result/CompleteText.text = "Game Over" 
	$Result.visible = true
