extends ScrollContainer
@export var difficulty_fish: String = "easy" #the fish list that will be read from. In lower case, easy, medium, hard
var default_fish_display = preload("res://scenes/default_fish_display.tscn")


func sort_by_fish_name(a, b):
	return a["weight"] < b["weight"]


func _ready() -> void:
	var fish_list: Array = load("user://fish_lists/%s.json" % difficulty_fish).data
	var fish_display_instance
	fish_list.sort_custom(sort_by_fish_name)
	for fish in fish_list:
		#creates a new fish_display in the grid container, to make the grid
		fish_display_instance = default_fish_display.instantiate()
		if fish["caught"] > 0:
			#if it has been caught it shows the fish. eventually this will include the image
			fish_display_instance.image_path = fish["image"]
			fish_display_instance.fish_name = fish["name"]
			fish_display_instance.caught = fish["caught"]
			fish_display_instance.biggest_catch = fish["biggest_catch"]
		else:
			#otherwise it will show a black default fish, and ??? as the name
			fish_display_instance.image_path = "res://assets/fish_images/uncaught.png"
			fish_display_instance.fish_name = "???"
			fish_display_instance.caught = 0
			fish_display_instance.biggest_catch = 0
		#putting it in the gridcontainer makes it all go into a nice grid
		$GridContainer.add_child(fish_display_instance)

func _process(delta: float) -> void:
	pass
