extends ScrollContainer
@export var difficulty_fish: String = "easy" #the fish list that will be read from. In lower case, easy, medium, hard
var default_fish_display = preload("res://scenes/default_fish_display.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fish_list = load("user://fish_lists/%s.json" % difficulty_fish).data
	var fish_display_instance
	for fish in fish_list:
		fish_display_instance = default_fish_display.instantiate()
		fish_display_instance.fish_name = fish["name"]
		fish_display_instance.caught = fish["caught"]
		fish_display_instance.biggest_catch = fish["biggest_catch"]
		$GridContainer.add_child(fish_display_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
