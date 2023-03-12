extends RigidBody2D

@export_range(0, 90) var rotation_range: float
@export var velocity_min: float
@export var velocity_max: float

func _ready() -> void:
  self.rotation_degrees += randf_range(-rotation_range, rotation_range)
  self.linear_velocity =\
    Vector2(randf_range(velocity_min, velocity_max), 0).rotated(rotation)
  var mob_types: PackedStringArray =\
    $AnimatedSprite2D.sprite_frames.get_animation_names()
  $AnimatedSprite2D.animation = mob_types[randi_range(0, mob_types.size() - 1)]
  $AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
  queue_free()
