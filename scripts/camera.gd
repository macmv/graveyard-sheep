extends Camera2D

export(float) var shake_start = 20
export(float) var shake_decrease = 2
var shake_amount = 0

func on_hurt():
  shake_amount = shake_start

func _process(delta):
  if shake_amount > 0:
    set_offset(Vector2( \
      rand_range(-1.0, 1.0) * shake_amount, \
      rand_range(-1.0, 1.0) * shake_amount \
    ))
    shake_amount -= shake_decrease
