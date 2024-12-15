extends Node2D
var random = RandomNumberGenerator.new()
var fish_list: Array = load("res://fish_lists/%s.json" % Game.difficulty).data
var fish: Dictionary = {}
var fish_file: FileAccess
var fish_weight: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish = fish_list.pop_at(random.randi_range(0,len(fish_list) - 1))
	fish["caught"] = fish["caught"] + 1
	fish_list.append(fish)
	fish_file = FileAccess.open("res://fish_lists/%s.json" % Game.difficulty, FileAccess.WRITE)
	print(JSON.stringify(fish_list, "\n\t"))
	fish_file.store_string(JSON.stringify(fish_list, "\t"))
	fish_file.close()
	$CanvasLayer/Control/Description.text = fish["desc"]
	$CanvasLayer/Control/Name.text = fish["name"]
	$CanvasLayer/Control/Caught.text = "caught: %s" % fish["caught"]
	fish_weight = fish["weight"] * Game.last_multiplier
	$CanvasLayer/Control/Weight.text = "weight: %s" % fish_weight
	print(fish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
