extends TextureButton
@export var difficulty:String
var r = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if difficulty != "easy":
		var anchor_pos = position
		var floating_tween
		while true:
			floating_tween = create_tween()
			floating_tween.tween_property(self, "position", Vector2(anchor_pos.x + r.randi_range(-10, 10), anchor_pos.y + r.randi_range(-10, 10)), randi_range(1, 3))
			await floating_tween.finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	var grow_tween = create_tween()
	grow_tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)


func _on_mouse_exited() -> void:
	var grow_tween = create_tween()
	grow_tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
