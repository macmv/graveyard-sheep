extends KinematicBody2D

export var speed = 150
export var attack_range = 200
export var nav_path : NodePath
onready var nav = get_node(nav_path)
export var attack_animation_path : NodePath
onready var attack_animation = get_node(attack_animation_path)

var path = PoolVector2Array()

func _process(delta):
  var path = nav.get_path_to_player(position)
  path = path

  var distance_to_walk = speed * delta

  while distance_to_walk > 0 and path.size() > 0:
    var distance_to_next_point = position.distance_to(path[0])
    if distance_to_walk <= distance_to_next_point:
      position += position.direction_to(path[0]) * distance_to_walk
    else:
      position = path[0]
      path.remove(0)
    distance_to_walk -= distance_to_next_point

  if nav.distance_to_player(position) < attack_range && !attack_animation.playing:
    nav.damage_player(position, 1)
    attack_animation.show()
    attack_animation.play()
    attack_animation.frame = 0
