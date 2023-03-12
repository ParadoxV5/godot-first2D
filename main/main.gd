extends Node

const QUARTER_TURN = TAU / 4
@export var mob_scene: PackedScene
var score: int

## New Game
func _on_hud_prep_game() -> void:
  get_tree().call_group(&"mobs", &"queue_free")
  set_score_text("-")
  $Music.play()
  score = 0
func _on_hud_start_game() -> void:
  set_score_text()
  $ScoreTimer.start()
  $MobTimer.start()

func set_score_text(score_text: String = str(score)) -> String:
  $HUD.set_score_text(score_text)
  return score_text
func _on_score_timer_timeout() -> void:
  score += 1
  set_score_text()

func _on_mob_timer_timeout() -> void:
  $MobPath/MobSpawnLocation.progress_ratio = randf()
  var mob: RigidBody2D = mob_scene.instantiate()
  mob.position = $MobPath/MobSpawnLocation.position
  mob.rotation = $MobPath/MobSpawnLocation.rotation + QUARTER_TURN
    # Direction along clockwise path + turn inward + randomize upon `add_child`
  add_child(mob)

## Game Over
func _on_player_hit() -> void:
  $HUD.game_over()
  $ScoreTimer.stop()
  $MobTimer.stop()
  $Music.stop()
  $DeathSound.play()
