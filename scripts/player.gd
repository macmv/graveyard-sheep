extends KinematicBody2D

export(float) var speed                   = 400
export(float) var friction_multiplier     = 0.82
export(float) var moving_multiplier       = 1.04
export(float) var acceleration_multiplier = 0.2
export(NodePath) var sprite_path
export(NodePath) var wool_path
export(NodePath) var collision_ray_path
export(NodePath) var attack_animation_path
var sprite
var wool
var vel
var collision_ray
var attack_animation

# Called when the node enters the scene tree for the first time.
func _ready():
  sprite = get_node(sprite_path) as AnimatedSprite
  wool = get_node(wool_path) as Wool
  collision_ray = get_node(collision_ray_path) as Area2D
  attack_animation = get_node(attack_animation_path) as AnimatedSprite
  vel = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
  wool.set_total(5)
  wool.set_amount(3)
  var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
  var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var move_vec = Vector2(x, y).normalized()
  if move_vec.length_squared() > 1e-05:
    sprite.play()
    rotation = -move_vec.angle_to(Vector2(1, 0))
    vel += move_vec * acceleration_multiplier
    vel *= moving_multiplier
  else:
    sprite.stop()
  vel *= friction_multiplier
  move_and_slide(vel * speed)

  if Input.is_action_just_pressed("attack"):
    attack_animation.show()
    attack_animation.play()
    attack_animation.frame = 0
    for body in collision_ray.get_overlapping_bodies():
      body.get_parent().remove_child(body)

