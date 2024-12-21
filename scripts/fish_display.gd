extends VBoxContainer
var fish_name: String
var caught: int
var biggest_catch: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Name.text = fish_name
	$Caught.text = "Caught: %s" % str(caught)
	$BiggestCatch.text = "Biggest catch: %s" % str(biggest_catch)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
