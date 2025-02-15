extends RichTextLabel

var goal_word:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_box_text_changed(new_text: String) -> void:
	print("a")
	var coloured_text:String = ""
	var i:int = 0
	var goal_character:String = ""
	for character in new_text:
		if len(goal_word) - 1 >= i:
			goal_character = goal_word[i]
		else:
			goal_character = "oob"
		if len(goal_word) - 1 < i:
			coloured_text += "".join(["[color=red]", character, "[/color]"])
		elif character == goal_character:
			coloured_text += "".join(["[color=white]", character, "[/color]"])
		else:
			coloured_text += "".join(["[color=red]", character, "[/color]"])
		i += 1
	if len(goal_word) > i:
		coloured_text += "[color=gray]"
		coloured_text += goal_word.right(len(goal_word) - (i))
		
	print(coloured_text)
	text = coloured_text
