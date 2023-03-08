extends Area2D

## How fast the player will move (pixels/sec).
@export var speed = 400

## Size of the game window.
var screen_size
func _ready():
  screen_size = get_viewport_rect().size
