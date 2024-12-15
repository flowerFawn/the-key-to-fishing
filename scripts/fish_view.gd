extends Node2D
var fish_list: Array = load("res://fish_lists/%s.json" % Game.difficulty).data
var fish: Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish = fish_list.pick_random()
	print(fish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
