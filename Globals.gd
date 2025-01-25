extends Node

var sphereInitialRadius = 10 # how to get this programmatically?
var sphereShrinkRate = 0.999
var sphereMaxRadius = 50
var sphereMinRadius = 5

var oxygen = 0
var time = 0 # time starts at 0
var cycleTime = 120 # how many seconds are one day

var building1 = 5
var building2 = 0

func reset():
	sphereInitialRadius = 10 # how to get this programmatically?
	sphereShrinkRate = 0.999
	sphereMaxRadius = 50
	sphereMinRadius = 5

	oxygen = 0
	time = 0 # time starts at 0
	cycleTime = 120 # how many seconds are one day

	building1 = 5
	building2 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
