extends RigidBody2D

func _ready() -> void:
  var mob_types: PackedStringArray =\
    $AnimatedSprite2D.get_sprite_frames().get_animation_names()
  $AnimatedSprite2D.animation = mob_types[randi_range(0, mob_types.size() - 1)]
  $AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
  queue_free()
