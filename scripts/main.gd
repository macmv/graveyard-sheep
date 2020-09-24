extends Viewport

func _ready():
  randomize()
  get_node("Map").load_room(0, 0, randi()%2, 0)
