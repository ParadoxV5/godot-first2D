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

var title_msg: String
func _ready() -> void:
  title_msg = $Message.text

func show_message(text: Variant, timeout: float) -> Signal:
  $Message.text = text
  return get_tree().create_timer(timeout).timeout

func game_over() -> void:
  $Message.show()
  await show_message(GAMEOVER_MSG, GAMEOVER_TIMEOUT)
  await show_message(title_msg, TITLE_TIMEOUT)
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
