extends Node2D
var random = RandomNumberGenerator.new()
var state: String = "starting"
var bob_moving:bool = false
var min_bob_distance: int = 0
var max_bob_distance: int = 0

func _ready() -> void:
	$Background.texture = load("res://assets/ui/backgrounds/%s_background.png" % Game.difficulty)
	$Foreground.texture = load("res://assets/ui/backgrounds/%s_foreground.png" % Game.difficulty)
	if Game.difficulty == "hard":
		$Midground.visible = true
	if Game.difficulty != "easy":
		var ship_sway_distance:int
		var ship_sway_tween
		if Game.difficulty == "medium":
			ship_sway_distance = 10
		elif Game.difficulty == "hard":
			ship_sway_distance = 20
		while true:
			ship_sway_tween = create_tween()
			ship_sway_tween.tween_property($Foreground, "position", Vector2(randi_range(-ship_sway_distance, ship_sway_distance), randi_range(0, ship_sway_distance * 2)), randi_range(1, 3))
			await ship_sway_tween.finished
			
func _process(delta: float) -> void:
	state = get_parent().state
	$Line2D.points[1] = $Bob.position + Vector2(4, -70)
	if state == "waiting":
		min_bob_distance = -50
		max_bob_distance = 50
	if state == "typing":
		min_bob_distance = -15
		max_bob_distance = 15
	if (state == "waiting" or state == "typing") and not bob_moving:
		#once the bob is static it is then moved to a random point over a random amount of time
		bob_moving = true
		var bob_movement_tween = create_tween()
		bob_movement_tween.tween_property($Bob, "position", get_bob_final_pos(), random.randf_range(0.6, 1))
		#once the tween finishes the flag is made false, so it can be started again
		await bob_movement_tween.finished
		bob_moving = false


func clamp(n, min, max):
	if n > max:
		return max
	elif min > n:
		return min
	else:
		return n


func get_bob_final_pos():
	#returns a point a random amount away from the bob, within certain a certain area
	var final_pos = Vector2(0, 0)
	final_pos.x = clamp($Bob.position.x + random.randi_range(min_bob_distance, max_bob_distance), 250, 1670)
	final_pos.y = clamp($Bob.position.y + random.randi_range(min_bob_distance, max_bob_distance), 100, 700)
	return final_pos
