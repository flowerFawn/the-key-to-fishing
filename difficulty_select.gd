extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_fishing_with_difficulty_change(difficulty: String):
	Game.difficulty = difficulty
	get_tree().change_scene_to_file("res://scenes/typing_scene.tscn")
	
func main_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
