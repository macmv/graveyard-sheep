extends AnimatedSprite

func _ready():
  connect("frame_changed", self, "_on_frame_changed")
  hide()

func _on_frame_changed():
  if frame == frames.get_frame_count(animation) - 1:
    playing = false
    hide()
