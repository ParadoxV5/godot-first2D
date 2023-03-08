extends Area2D

## How fast the player will move (pixels/sec).
@export var speed = 400
## Size of the game window.
var screen_size: Vector2
##
signal hit

func _ready():
  hide()
  screen_size = get_viewport_rect().size
func start(position2: Vector2):
  position = position2
  show()
  $CollisionShape2D.disabled = false

func _process(delta):
  var velocity = Vector2.ZERO # The player's movement vector.
  if Input.is_action_pressed(&"move_right"):
    velocity.x += 1
  if Input.is_action_pressed(&"move_left"):
    velocity.x -= 1
  if Input.is_action_pressed(&"move_down"):
    velocity.y += 1
  if Input.is_action_pressed(&"move_up"):
    velocity.y -= 1
  
  if velocity.length() > 0:
    if velocity.x == 0:
      $AnimatedSprite2D.animation = &"up"
      $AnimatedSprite2D.flip_v = velocity.y > 0
    else:
      $AnimatedSprite2D.animation = &"walk"
      $AnimatedSprite2D.flip_v = false
      $AnimatedSprite2D.flip_h = velocity.x < 0
    $AnimatedSprite2D.play()
    
    var position2: Vector2 = position + velocity.normalized() * speed * delta
    position2.x = clamp(position2.x, 0, screen_size.x)
    position2.y = clamp(position2.y, 0, screen_size.y)
    position = position2
  else:
    $AnimatedSprite2D.stop()

func _on_body_entered(_body):
  hit.emit()
  hide()
  $CollisionShape2D.set_deferred(&"disabled", true)
    # Must be deferred as a physics callback can't change a physics property.
