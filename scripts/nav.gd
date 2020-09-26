extends Navigation2D

func get_path_to_player(position):
  return get_simple_path(position, get_parent().player.position)

func distance_to_player(position):
  return position.distance_to(get_parent().player.position)
