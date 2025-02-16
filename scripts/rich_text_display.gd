extends RichTextLabel

var goal_word:String
var untyped_colour:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#the normal grey doesn't show up well on the medium ui, so I made it a different colour on medium
	if Game.difficulty == "medium":
		untyped_colour = "#7c7c7c"
	else:
		untyped_colour = "gray"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_box_text_changed(new_text: String) -> void:
	print("a")
	var coloured_text:String = ""
	var i:int = 0
	var goal_character:String = ""
	#for each charcater in the input box text it is either made red or white
	#red if it is accurate to the equivilent character in the goal word, red if not
	#if it goes out of bounds for the goal word, it is red
	#once all characters in the inputted text are done, the remainder of the goal word is added in grey
	for character in new_text:
		#if in bounds gets the character it should be
		if len(goal_word) - 1 >= i:
			goal_character = goal_word[i]
		else:
			goal_character = "oob"
		#if the character's position is out of bounds of the goal word, it is made red
		if len(goal_word) - 1 < i:
			coloured_text += "".join(["[color=red]", character, "[/color]"])
		#if it is in the correct place, it is made white
		elif character == goal_character:
			coloured_text += "".join(["[color=white]", character, "[/color]"])
		#if it is not the goal character, is is made red
		else:
			coloured_text += "".join(["[color=red]", character, "[/color]"])
		#i is the index, used for both the input text and goal word character to be compared to each other
		i += 1
	if len(goal_word) > i:
		#adds the rest of the goal word to the end
		coloured_text += "[color=%s]" % untyped_colour
		coloured_text += goal_word.right(len(goal_word) - (i))
		coloured_text += "[/color]"
		
	print(coloured_text)
	text = coloured_text
