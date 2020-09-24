extends AnimatedSprite
class_name Wool

var children

func _ready():
  children = []

func set_total(amount):
  amount -= 1
  if len(children) < amount:
    while len(children) < amount:
      var inst = self.duplicate()
      inst.position.y += len(children) * 100 + 100
      self.get_parent().add_child(inst)
      children.push_back(inst)
  elif len(children) > amount:
    while len(children) > amount:
      var inst = children.pop_back()
      self.get_parent().remove_child(inst)
  print("Setting wool to:", amount)

func set_amount(amount):
  self.set_frame(0 if amount == 0 else 1)
  amount -= 1
  for i in range(children.size()):
    children[i].set_frame(1 if i < amount else 0)
