extends Node2D
var random = RandomNumberGenerator.new()
const SIZE_PULLS: Dictionary = {"small":1, "medium":2, "big":3, "large":4, "huge":5, "massive":6}
var fish_list: Array = load("res://fish_lists/%s.json" % Game.difficulty).data
var fish: Dictionary = {}
var goal_word: String = ""
var state: String = "starting"
var word_list: Array = load("res://word_lists/%s.json" % Game.difficulty).data
var first_wait: bool = true
var pulls_left: int = 0
var total_time_left: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish = fish_list.pop_at(random.randi_range(0,len(fish_list) - 1))
	pulls_left = SIZE_PULLS[fish["size"]]
	$CanvasLayer/Control/CastButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if state == "waiting" and $CanvasLayer/Control/WordDisplay.text == "Fishing for fishes" or $CanvasLayer/Control/WordDisplay.text == "Pulling the fishie back in":
		waiting_text_dot_cycle()

func waiting_text_dot_cycle():
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
	#starts the timer to give a wait time till the text appears
	state = "waiting"
	$CanvasLayer/Control/CastButton.disabled = true
	if first_wait:
		$CanvasLayer/Control/WordDisplay.text = "Fishing for fishes"
	else:
		$CanvasLayer/Control/WordDisplay.text = "Pulling the fishie back in"
	$TimeToBob.wait_time = random.randf_range(2.0, 5.0)
	$TimeToBob.start()


func get_word():
	return word_list.pick_random()
	
func start_typing():
	
	if first_wait:
		first_wait = false
	state = "typing"
	goal_word = get_word()
	#sets the player to already be selected on the input as soon as they can type
	#starts the timer that counts how long they have spent
	$CanvasLayer/Control/InputBox.text = ""
	$CanvasLayer/Control/CastButton.text = "Type: %s!" % goal_word
	$CanvasLayer/Control/WordDisplay.text = "It's a %s shadow!" % fish["size"]
	$CanvasLayer/Control/InputBox.editable = true
	$CanvasLayer/Control/InputBox.grab_focus()
	$TimeLeft.start()
	
	
func _on_input_box_text_changed(new_text: String) -> void:
	#checks if the most recent version of the word is the goal word, so it can be 
	if new_text.to_lower() == goal_word and state == "typing":
		pulls_left -= 1
		total_time_left += $TimeLeft.time_left
		$TimeLeft.stop()
		$CanvasLayer/Control/InputBox.editable = false
		if pulls_left == 0:
			$CanvasLayer/Control/WordDisplay.text = "You caught it!"
			state = "success"
			print(new_text)
			#to be used to multiply weight
			var time_left_percentage = total_time_left / (5 * SIZE_PULLS[fish["size"]])
			var time_multiplier = time_left_percentage + 0.2
			var length_multiplier = (float(len(goal_word)) / 100) + 1
			var total_multiplier = time_multiplier * length_multiplier * random.randf_range(0.95, 1.05)
			Game.last_multiplier = total_multiplier
			Game.caught_fish = fish
			$CanvasLayer/Control/ToFishView.disabled = false
			$CanvasLayer/Control/ToFishView.visible = true
			$CanvasLayer/Control/ToFishView.grab_focus()
		else:
			start_waiting()

func time_finished() -> void:
	if state == "typing":
		state = "failed"
		$CanvasLayer/Control/InputBox.editable = false
		$CanvasLayer/Control/WordDisplay.text = "The fish got away!"
		$CanvasLayer/Control/ToRetry.disabled = false
		$CanvasLayer/Control/ToRetry.visible = true
