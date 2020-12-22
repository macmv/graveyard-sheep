extends Node2D

func _ready():
  var wool = $GUI/Gui/Top/WoolHBox/WoolMargin
  wool.set_total(5)
  wool.set_amount(5)
  $Player.wool = wool
  $Player.camera = $Player/Camera2D
