extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


func _draw():
  frame = get_parent().frame
  animation = get_parent().animation
  playing = get_parent().playing


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
