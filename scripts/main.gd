extends Node2D

func _ready():
  $Player.wool_sprite = $GUI/Wool
  $Player.camera = $Player/Camera2D
