extends KinematicBody2D

export(float) var speed            = 30
export(float) var friction         = 0.85
export(float) var knockback_amount = 10
export(float) var attack_range     = 140
export(float) var view_distance    = 1000

export(NodePath) var attack_animation_path
onready var attack_animation = get_node(attack_animation_path)

var path = PoolVector2Array()
var vel = Vector2(0, 0)
var health = 5
var player

func _ready():
  player = get_node("../" + get_parent().player_path)

func _physics_process(delta):
  var move_vec = (player.position - position).normalized()
  rotation = -move_vec.angle_to(Vector2(0, -1))
  vel += move_vec * speed
  vel *= friction
  move_and_slide(vel)

  if position.distance_to(player.position) < attack_range && !attack_animation.playing:
    player.damage(position, 1)
    attack_animation.show()
    attack_animation.play()
    attack_animation.frame = 0

func damage(from_pos, amount):
  health -= amount
  vel += (position - from_pos).normalized() * amount * knockback_amount
  if health <= 0:
    get_parent().remove_child(self)
