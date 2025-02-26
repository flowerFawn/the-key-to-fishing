extends ColorRect
var r = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Game.difficulty == "hard":
		visible = true
		color = Color(0.75, 0.75, 0.75)
		while true:
			#changes the colour to look like lightning striking
			await get_tree().create_timer(r.randf_range(3, 10)).timeout
			strike()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func strike():
	var tweener
	tweener = create_tween()
	tweener.tween_property(self, "color", Color(1, 1, 1), r.randf_range(0.1, 0.2))
	await tweener.finished
	await get_tree().create_timer(r.randf_range(0.1, 0.15)).timeout
	tweener = create_tween()
	tweener.tween_property(self, "color", Color(0.75, 0.75, 0.75), r.randf_range(0.05, 0.15))
	await tweener.finished
