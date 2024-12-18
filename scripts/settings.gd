extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func back_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	

func reset_data():
	#goes through the default json files, and overwrites the user jsons with the same name with the contents of the default.
	var default_data: Array = []
	var new_data_location: FileAccess
	for difficulty in ["easy", "medium", "hard"]:
		new_data_location = FileAccess.open("user://fish_lists/%s.json" % difficulty, FileAccess.WRITE)
		default_data = load("res://fish_lists/%s.json" % difficulty).data
		new_data_location.store_string(JSON.stringify(default_data, "\t"))
		new_data_location.close()
