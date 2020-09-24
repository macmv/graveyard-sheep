extends KinematicBody2D

export var speed = 10
export(NodePath) var sprite_path
export(NodePath) var wool_path
var sprite
var wool

# Called when the node enters the scene tree for the first time.
func _ready():
  sprite = get_node(sprite_path) as AnimatedSprite
  wool = get_node(wool_path) as Wool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
  wool.set_total(5)
  wool.set_amount(3)
  var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
  var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var move_vec = Vector2(x, y)
  if move_vec.length_squared() > 1e-05:
    sprite.play()
    rotation = -move_vec.angle_to(Vector2(1, 0))
  else:
    sprite.stop()
  move_and_slide(move_vec * speed)
