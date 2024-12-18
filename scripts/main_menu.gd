extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var user_dir = DirAccess.open("user://.")
	var default_data: Array = []
	var new_data_location: FileAccess
	if not user_dir.dir_exists("user://fish_lists"):
		user_dir.make_dir("user://fish_lists")
	for difficulty in ["easy", "medium", "hard"]:
		if not FileAccess.file_exists("user://fish_lists/%s.json" % difficulty):
			new_data_location = FileAccess.open("user://fish_lists/%s.json" % difficulty, FileAccess.WRITE)
			default_data = load("res://fish_lists/%s.json" % difficulty).data
			new_data_location.store_string(JSON.stringify(default_data, "\t"))
			new_data_location.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func load_new_scene(path: String):
	get_tree().change_scene_to_file(path)


func quit():
	get_tree().quit()
	
