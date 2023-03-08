extends Node

@export var mob_scene: PackedScene
var score: int

func _on_hud_prep_game() -> void:
  get_tree().call_group(&"mobs", &"queue_free")
  set_score_text("-")
  score = 0
  $Player.start($StartPosition.position)
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
  mob.rotation_degrees =\
    $MobPath/MobSpawnLocation.rotation_degrees + randi_range(45, 135)
    # Direction along clockwise path + 90° + randi_range(-45, 45)
    # TODO: @export
  mob.linear_velocity = Vector2(randf_range(150, 250), 0).rotated(mob.rotation)
    # TODO: @export
  add_child(mob)

## Game Over
func _on_player_hit() -> void:
  $HUD.game_over()
  $ScoreTimer.stop()
  $MobTimer.stop()
