extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	var grow_tween = create_tween()
	grow_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)


func _on_mouse_exited() -> void:
	var grow_tween = create_tween()
	grow_tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
