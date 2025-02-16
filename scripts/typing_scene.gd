extends Node2D
var random = RandomNumberGenerator.new()
const SIZE_PULLS: Dictionary = {"small":1, "medium":2, "big":3, "large":4, "huge":5, "massive":6, "gigantic":8, "Incomprehensible":12}
var fish_list: Array = load("user://fish_lists/%s.json" % Game.difficulty).data
var fish: Dictionary = {}
var goal_word: String = ""
var state: String = "starting"
var word_list: Array = load("res://word_lists/%s.json" % Game.difficulty).data
var first_wait: bool = true
var pulls_left: int = 0
var total_time_left: float = 0
var fish_index: int = 0
var total_length: int = 0
func _ready() -> void:
	var difficulty_times = {"easy":4, "medium":5, "hard":6}
	$TimeLeft.wait_time = difficulty_times[Game.difficulty]
	#picks a fish so that it can be used in the view and to determine amount of pulls
	fish_index = random.randi_range(0,len(fish_list) - 1)
	fish = fish_list[fish_index]
	#sets amount of pulls based on size
	pulls_left = SIZE_PULLS[fish["size"]]
	#grab focus is used a lot in this so the user doesn't have to click on an input to start typing
	$CanvasLayer/Control/CastButton.grab_focus()


func _process(_delta: float) -> void:
	#calls that ... .. . thingy when it should be happening
	if state == "waiting" and $CanvasLayer/Control/WordDisplay.text == "Fishing for fishes" or $CanvasLayer/Control/WordDisplay.text == "Pulling the fishie back in":
		waiting_text_dot_cycle()

func waiting_text_dot_cycle():
	#does that ... .. . thingy, and changes the text depending if it's fishing or pulling
	for _a in range(3):
		if state == "waiting":
			$CanvasLayer/Control/WordDisplay.text = $CanvasLayer/Control/WordDisplay.text + "."
			await get_tree().create_timer(0.5).timeout
		else:
			break
	await get_tree().create_timer(0.5).timeout
	if state == "waiting" and first_wait:
		$CanvasLayer/Control/WordDisplay.text = "Fishing for fishes"
	elif state == "waiting" and not first_wait:
		$CanvasLayer/Control/WordDisplay.text = "Pulling the fishie back in"


func start_waiting():
	$CanvasLayer/Control/CastButton.text = "Splish!"
	#changes the state so the input can't be changed
	state = "waiting"
	#disables the button so it can't be used anymore, starting the wait again
	$CanvasLayer/Control/CastButton.disabled = true
	#changes displayed text based on if it's fishing or pulling
	if first_wait:
		$CanvasLayer/Control/WordDisplay.text = "Fishing for fishes"
	else:
		$CanvasLayer/Control/WordDisplay.text = "Pulling the fishie back in"
	$TimeToBob.wait_time = random.randf_range(2.0, 5.0)
	#starts the timer to give a wait time till the next word appears
	$TimeToBob.start()


func get_word():
	var new_word = word_list.pick_random()
	$CanvasLayer/Control/RichTextDisplay.goal_word = new_word
	return new_word
	
func start_typing():
	#changes, so that next time the text will be for pulling the fishie back in
	if first_wait:
		first_wait = false
	state = "typing"
	goal_word = get_word()
	total_length += len(goal_word)
	#sets the player to already be selected on the input as soon as they can type
	#starts the timer that counts how long they have spent
	$CanvasLayer/Control/InputBox.text = ""
	$CanvasLayer/Control/CastButton.text = "Type: %s!" % goal_word
	$CanvasLayer/Control/WordDisplay.text = "It's a %s shadow!" % fish["size"]
	$CanvasLayer/Control/RichTextDisplay._on_input_box_text_changed("")
	await get_tree().create_timer(0.5).timeout
	#the input box is only actually made useable at this point
	$CanvasLayer/Control/InputBox.editable = true
	$CanvasLayer/Control/InputBox.grab_focus()
	$TimeLeft.start()
	
	
func _on_input_box_text_changed(new_text: String) -> void:
	#every time the text in the input is changed it checks if they finished the word
	if new_text.to_lower() == goal_word and state == "typing":
		pulls_left -= 1
		#total_time_left is eventually used to calculate percentage of time remaining
		total_time_left += $TimeLeft.time_left
		$TimeLeft.stop()
		#stops the user editing the input while fishing is going on
		$CanvasLayer/Control/InputBox.editable = false
		if pulls_left == 0:
			$CanvasLayer/Control/WordDisplay.text = "You caught it!"
			state = "success"
			#to be used to multiply weight
			var time_left_percentage = total_time_left / ($TimeLeft.wait_time * SIZE_PULLS[fish["size"]])
			var time_multiplier = (time_left_percentage / 2) + 0.8
			#sets length_multiplier to the average length of a word this fish as 1% each, plus 1
			var length_multiplier = (float(total_length / SIZE_PULLS[fish["size"]] ) / 100) + 1
			var total_multiplier = time_multiplier * length_multiplier * random.randf_range(0.95, 1.05)
			#stores them all in the autoload Game so that the fish_view.gd script can use them
			Game.last_multiplier = total_multiplier
			Game.caught_fish = fish
			Game.fish_index = fish_index
			#makes the button that brings you to fish_view visible, and leaves the button that brings you to retry invisible
			$CanvasLayer/Control/ToFishView.disabled = false
			$CanvasLayer/Control/ToFishView.visible = true
			$CanvasLayer/Control/ToFishView.grab_focus()
		else:
			#starts the game again if the pulls are not all complete
			start_waiting()

func time_finished() -> void:
	if state == "typing":
		state = "failed"
		#stops the user editing their input after losing
		$CanvasLayer/Control/InputBox.editable = false
		$CanvasLayer/Control/WordDisplay.text = "The fish got away!"
		#makes the button to retry appear
		$CanvasLayer/Control/ToRetry.disabled = false
		$CanvasLayer/Control/ToRetry.visible = true


func _on_input_box_focus_exited() -> void:
	print(state)
	if state == "typing":
		await get_tree().create_timer(0.00000001).timeout
		$CanvasLayer/Control/InputBox.grab_focus()
