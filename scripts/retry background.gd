extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Game.difficulty != "easy":
		texture = load("res://assets/ui/backgrounds/fish_view_harder_background.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
