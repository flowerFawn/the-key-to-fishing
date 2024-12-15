extends Button
@export var grabs_focus: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if grabs_focus:
		grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_new_scene(path: String):
	get_tree().change_scene_to_file(path)
