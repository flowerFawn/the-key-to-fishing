extends Node2D
var random = RandomNumberGenerator.new()
var goal_word: String = ""
var state: String = "starting"
var word_list: Array = load("res://word_lists/%s.json" % Game.difficulty).data
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Control/CastButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if state == "waiting" and $CanvasLayer/Control/WordDisplay.text == "Fishing for fishes":
		waiting_text_dot_cycle()

func waiting_text_dot_cycle():
	for _a in range(3):
		if state == "waiting":
			$CanvasLayer/Control/WordDisplay.text = $CanvasLayer/Control/WordDisplay.text + "."
			await get_tree().create_timer(0.5).timeout
		else:
			break
	await get_tree().create_timer(0.5).timeout
	if state == "waiting":
		$CanvasLayer/Control/WordDisplay.text = "Fishing for fishes"


func start_waiting():
	#starts the timer to give a wait time till the text appears
	state = "waiting"
	$CanvasLayer/Control/CastButton.disabled = true
	$CanvasLayer/Control/WordDisplay.text = "Fishing for fishes"
	$TimeToBob.wait_time = random.randf_range(2.0, 5.0)
	$TimeToBob.start()


func get_word():
	return word_list.pick_random()
	
func start_typing():
	state = "typing"
	goal_word = get_word()
	#sets the player to already be selected on the input as soon as they can type
	#starts the timer that counts how long they have spent
	$CanvasLayer/Control/WordDisplay.text = "Type: %s!" % goal_word
	$CanvasLayer/Control/InputBox.editable = true
	$CanvasLayer/Control/InputBox.grab_focus()
	$TimeLeft.start()
	
	
func _on_input_box_text_changed(new_text: String) -> void:
	#checks if the most recent version of the word is the goal word, so it can be 
	if new_text.to_lower() == goal_word and state == "typing":
		$TimeLeft.stop()
		$CanvasLayer/Control/WordDisplay.text = "You caught it!"
		state = "success"
		print(new_text)
		#to be used to multiply weight
		var time_left_percentage = $TimeLeft.time_left / 5
		var time_multiplier = time_left_percentage + 0.2
		var length_multiplier = (float(len(goal_word)) / 100) + 1
		var total_multiplier = time_multiplier * length_multiplier * random.randf_range(0.95, 1.05)
		Game.last_multiplier = total_multiplier
		$CanvasLayer/Control/ToFishView.disabled = false
		$CanvasLayer/Control/ToFishView.visible = true


func time_finished() -> void:
	if state == "typing":
		state = "failed"
		$CanvasLayer/Control/WordDisplay.text = "The fish got away!"
		$CanvasLayer/Control/ToRetry.disabled = false
		$CanvasLayer/Control/ToRetry.visible = true

func load_to_scene(path):
	get_tree().change_scene_to_file(path)
