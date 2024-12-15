extends Node2D
var random = RandomNumberGenerator.new()
var fish_list: Array = load("res://fish_lists/%s.json" % Game.difficulty).data
var fish: Dictionary = {}
var fish_file: FileAccess
var fish_weight: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish = Game.caught_fish
	fish["caught"] = fish["caught"] + 1
	fish_list.append(fish)
	fish_file = FileAccess.open("res://fish_lists/%s.json" % Game.difficulty, FileAccess.WRITE)
	fish_file.store_string(JSON.stringify(fish_list, "\t"))
	fish_file.close()
	$CanvasLayer/Control/Description.text = fish["desc"]
	$CanvasLayer/Control/Name.text = fish["name"]
	$CanvasLayer/Control/VBoxContainer/Caught.text = "caught: %s" % fish["caught"]
	fish_weight = fish["weight"] * Game.last_multiplier
	$CanvasLayer/Control/VBoxContainer/Weight.text = "weight: %slbs" % snapped(fish_weight, 0.01)
	$CanvasLayer/Control/VBoxContainer/Size.text = fish["size"]
	$CanvasLayer/Control/Next.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
