extends Node

var sphereInitialRadius
var sphereShrinkRate
var sphereMaxRadius
var sphereMinRadius

var oxygen
var time
var cycleTime

var building1
var building2

func reset():
	sphereInitialRadius = 10 # how to get this programmatically?
	sphereShrinkRate = 0.999
	sphereMaxRadius = 50
	sphereMinRadius = 5

	oxygen = 0
	time = 0 # time starts at 0
	cycleTime = 120 # how many seconds are one day

	building1 = 0
	building2 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
