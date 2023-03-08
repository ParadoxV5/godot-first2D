extends Node

@export var mob_scene: PackedScene
var score: int

func new_game() -> void:
  score = 0
  $Player.start($StartPosition.position)
  $StartTimer.start()

func _on_start_timer_timeout() -> void:
  $ScoreTimer.start()
  $MobTimer.start()

func _on_score_timer_timeout() -> void:
  score += 1

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
  $ScoreTimer.stop()
  $MobTimer.stop()
