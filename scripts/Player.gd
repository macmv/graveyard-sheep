extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 10


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
  var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
  var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  move_and_slide(Vector2(x, y) * speed)
