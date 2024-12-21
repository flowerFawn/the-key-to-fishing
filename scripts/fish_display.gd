extends VBoxContainer
var fish_name: String
var caught: int
var biggest_catch: float
var image_path: String


func _ready() -> void:
	#this script only exists to change the labels and image for each instance, as direct access is impossible I think??
	if ResourceLoader.exists(image_path):
		$Image.texture = load(image_path)
	$Name.text = fish_name
	$Caught.text = "Caught: %s" % str(caught)
	$BiggestCatch.text = "Biggest catch: %slbs" % str(biggest_catch)


func _process(delta: float) -> void:
	pass
