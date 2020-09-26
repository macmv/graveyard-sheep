extends KinematicBody2D

export(float) var speed                   = 150
export(float) var friction_multiplier     = 0.82
export(float) var moving_multiplier       = 1.04
export(float) var acceleration_multiplier = 0.2
export(float) var knockback_amount        = 10
export(float) var attack_range            = 140
export(float) var view_distance           = 1000

export var nav_path : NodePath
export var attack_animation_path : NodePath
onready var nav = get_node(nav_path)
onready var attack_animation = get_node(attack_animation_path)

var path = PoolVector2Array()
var vel = Vector2(0, 0)
var health = 5

func _physics_process(delta):
  if nav.distance_to_player(position) < view_distance:
    path = nav.get_path_to_player(position)
    path.remove(0) # First point is always the enemy's position
    var move_vec = position.direction_to(path[0]).normalized()
    vel += move_vec * acceleration_multiplier
    vel *= moving_multiplier
  vel *= friction_multiplier
  move_and_slide(vel * speed)

  if nav.distance_to_player(position) < attack_range && !attack_animation.playing:
    nav.damage_player(position, 1)
    attack_animation.show()
    attack_animation.play()
    attack_animation.frame = 0

func damage(from_pos, amount):
  health -= amount
  vel += (position - from_pos).normalized() * amount * knockback_amount
  if health <= 0:
    get_parent().remove_child(self)
