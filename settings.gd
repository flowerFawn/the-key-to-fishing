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
	var defaults = DirAccess.open("res://fish_lists/default fish lists/")
	var user_file = FileAccess
	var default_data: Array = []
	for default_file in defaults.get_files():
		default_data = load("res://fish_lists/default fish lists/%s" % default_file).data
		user_file = FileAccess.open("res://fish_lists/%s" % default_file, FileAccess.WRITE)
		user_file.store_string(JSON.stringify(default_data, "\t"))
		user_file.close()
		
