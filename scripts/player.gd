extends KinematicBody2D

export(float) var speed            = 120
export(float) var friction         = 0.8
export(float) var knockback_amount = 2

var wool
var camera
var vel = Vector2(0, 0)

func _physics_process(delta):
  var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
  var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  var move_vec = Vector2(x, y).normalized()
  if move_vec.length_squared() > 1e-05:
    $Sprite.play()
    rotation = -move_vec.angle_to(Vector2(1, 0))
    vel += move_vec * speed
  else:
    $Sprite.stop()
  vel *= friction
  move_and_slide(vel)

  if Input.is_action_just_pressed("attack"):
    $DashAnimation.show()
    $DashAnimation.play()
    $DashAnimation.frame = 0
    for body in $HitTrigger.get_overlapping_bodies():
      body.damage(position, 1)
      wool.add(1)

func damage(from_pos, amount):
  wool.add(-amount)
  vel += (position - from_pos).normalized() * knockback_amount
  camera.on_hurt()
