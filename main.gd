extends Node

@onready var sphere = $Sphere
@onready var scoresLabel = $UI/Scores
@onready var timeLabel = $UI/Time

var sphereInitialRadius = 10 # how to get this programmatically?
var sphereShrinkRate = 0.999

var oxygen = 0
var time = 0 # time starts at 0
var cycleTime = 120 # how many seconds are one day

func _on_tick_timeout():
	var oxygenOld = oxygen
	oxygen = Globals.building1 * 0.002 - Globals.building2 * 0.003
	if oxygen != oxygenOld:
		sphereShrinkRate = sphereShrinkRate + oxygen
	
	var scaleBefore = sphere.scale	
	var scaleAfter = scaleBefore * Vector3(sphereShrinkRate, sphereShrinkRate, sphereShrinkRate)
	sphere.scale = scaleAfter
	
	var sphereArea = sphere.scale.x * sphereInitialRadius * sphereInitialRadius * PI
	scoresLabel.text = "Bubble Area: " + str(round(sphereArea)) + "m²" + str((oxygen))
	
	time += 0.1
	var timeRad = (time / cycleTime) * 2 * PI 
	$Sun.position = Vector3(-1 * cos(timeRad) * 100, cos(timeRad) * 100, 0) # position moves in circle around z axis
	$Sun.rotation = Vector3(-1 * cos(timeRad), PI / 2, 0) # rotation moves from noon (top down) to sunset (from left) and so on
	$Sun.light_color = Color(1, 1, cos(timeRad), 1)
	timeLabel.text = "Time of Day: " + str((12 + int(round((time / cycleTime) * 24))) % 24)
