extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_new_scene(path: String):
	get_tree().change_scene_to_file(path)


func quit():
	get_tree().quit()
	
