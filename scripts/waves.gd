extends Sprite2D
var r = RandomNumberGenerator.new()

func _ready() -> void:
	#what is the thing waves do called? waving??
	var waving_tween
	while true:
		waving_tween = create_tween()
		waving_tween.tween_property(self, "position", Vector2(960 + r.randi_range(-10, 10), 540 + r.randi_range(-10, 10)), r.randi_range(1, 3))
		await waving_tween.finished
		
func _process(delta: float) -> void:

	pass
