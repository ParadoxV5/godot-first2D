extends CanvasLayer

const GAMEOVER_TEXT: String = "Game Over"

## Notifies `Main` node when pressing the start button
signal start_game

func show_message(text: Variant, timeout: float) -> Signal:
  $Message.text = text
  $Message.show()
  return get_tree().create_timer(timeout).timeout

func show_game_over() -> void:
  await show_message(GAMEOVER_TEXT, 2)
  await show_message("Dodge the Creeps!", 1)
  $StartButton.show()

func update_score(score: Variant) -> void:
  $ScoreLabel.text = score

func _on_start_button_pressed() -> void:
  start_game.emit()
func _on_start_game() -> void:
  $StartButton.hide()
