extends CanvasLayer

const MAX_LIVES = 3


func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()


func show_game_over() -> void:
	show_message("Game Over")


func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)


func update_lives(num_lives: int) -> void:
	var lives_to_hide = MAX_LIVES - num_lives
	for i in range(lives_to_hide):
		$Lives.get_child(i).hide()
