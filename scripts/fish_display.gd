extends VBoxContainer
var fish_name: String
var caught: int
var biggest_catch: float


func _ready() -> void:
	#this script only exists to change the labels and image for each instance, as direct access is impossible I think??
	$Name.text = fish_name
	$Caught.text = "Caught: %s" % str(caught)
	$BiggestCatch.text = "Biggest catch: %s" % str(biggest_catch)


func _process(delta: float) -> void:
	pass
