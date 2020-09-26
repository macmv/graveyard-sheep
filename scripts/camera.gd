extends Camera2D

func on_hurt():
  set_offset(Vector2( \
    rand_range(-1.0, 1.0) * 20, \
    rand_range(-1.0, 1.0) * 20 \
  ))
