extends CanvasLayer

const READY_MSG: String = "Get Ready"
const READY_TIMEOUT: int = 2
const GAMEOVER_MSG: String = "Game Over"
const GAMEOVER_TIMEOUT: int = 2
const TITLE_TIMEOUT: int = 1

## Notifies when pressing the start button
signal prep_game
## Notifies after a timeout after `prep_game`
signal start_game

func show_message(text: Variant, timeout: float) -> Signal:
  $Message.text = text
  return get_tree().create_timer(timeout).timeout

func game_over() -> void:
  $Message.show()
  await show_message(GAMEOVER_MSG, GAMEOVER_TIMEOUT)
  await show_message("Dodge the Creeps!", TITLE_TIMEOUT) #TODO: unify string
  $StartButton.show()

func set_score_text(score_text: String) -> void:
  $ScoreLabel.text = score_text

func _on_start_button_pressed() -> void:
  prep_game.emit()
func _on_prep_game() -> void:
  $StartButton.hide()
  await show_message(READY_MSG, READY_TIMEOUT)
  start_game.emit()
func _on_start_game() -> void:
  $Message.hide()
