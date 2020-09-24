extends MarginContainer
class_name Wool

export var filled_texture : Texture
export var empty_texture  : Texture
export var image_path     : NodePath
onready var image = get_node(image_path)

var children = []

func _ready():
  set_filled(true)

func set_total(amount):
  amount -= 1
  if len(children) < amount:
    while len(children) < amount:
      var inst = self.duplicate()
      self.get_parent().add_child(inst)
      children.push_back(inst)
  elif len(children) > amount:
    while len(children) > amount:
      var inst = children.pop_back()
      self.get_parent().remove_child(inst)

func set_amount(amount):
  set_filled(amount >= children.size() + 1)
  var i = 0
  for j in range(children.size() - 1, -1, -1):
    children[j].set_filled(i < amount)
    i += 1

func set_filled(filled):
  if filled:
    image.set_texture(filled_texture)
  else:
    image.set_texture(empty_texture)
