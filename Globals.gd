extends Node

var sphereInitialRadius = 10 # how to get this programmatically?
var sphereShrinkRate = 0.999
var sphereMaxRadius = 50
var sphereMinRadius = 5

var oxygen = 0
var time = 0 # time starts at 0
var cycleTime = 120 # how many seconds are one day

var building1 = 0
var building2 = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
