extends KinematicBody2D

export(float) var speed            = 120
export(float) var friction         = 0.8
export(float) var knockback_amount = 2
export(float) var dash_length      = 0.5
export(float) var dash_speed       = 300

var wool
var camera
var vel = Vector2(0, 0)
var dash_time = 0
var dash_vec = Vector2(0, 0)

func _physics_process(delta):
  var move_vec = Vector2(0, 0)
  if dash_time > 0:
    dash_time -= delta
    if dash_time < 0:
      $DashAnimation.playing = false
      $DashAnimation.hide()
      dash_time = 0
    vel += dash_vec * dash_speed
  else:
    var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    move_vec = Vector2(x, y).normalized()
    if move_vec.length_squared() > 1e-05:
      $Sprite.play()
      rotation = -move_vec.angle_to(Vector2(1, 0))
      vel += move_vec * speed
    else:
      $Sprite.stop()
  vel *= friction
  move_and_slide(vel)

  if dash_time == 0 && Input.is_action_just_pressed("attack") && move_vec.length_squared() > 1e-05:
    $DashAnimation.show()
    $DashAnimation.playing = true
    $DashAnimation.frame = 0
    $Sprite.play()
    dash_time = dash_length
    dash_vec = move_vec

  if dash_time > 0:
    for body in $HitTrigger.get_overlapping_bodies():
      body.damage(position, 1)
      wool.add(1)

func damage(from_pos, amount):
  wool.add(-amount)
  vel += (position - from_pos).normalized() * knockback_amount
  camera.on_hurt()
