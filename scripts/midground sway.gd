extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var waves_tween
	var wave_distance = 20
	while true:
		waves_tween = create_tween()
		waves_tween.tween_property(self, "position", Vector2(randi_range(-wave_distance, wave_distance) - 20, randi_range(0, wave_distance * 2)), randi_range(1, 3))
		await waves_tween.finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
