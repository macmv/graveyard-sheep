extends TileMap

export(PackedScene) var rooms_scene

func load_room(place_x, place_y, get_x, get_y):
  assert(rooms_scene != null)
  var rooms = rooms_scene.instance().get_node("Map")
  assert(rooms != null)
  for y in range(10):
    for x in range(10):
      var tile = rooms.get_cell(get_x * 11 + x, get_y * 11 + y)
      set_cell(place_x * 11 + x, place_y * 11 + y, tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
