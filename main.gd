extends Node

@onready var sphere = $Sphere
@onready var scores = $UI/Scores

var sphereInitialRadius = 10 # how to get this programmatically?
var sphereShrinkRate = 0.999
var building1 = 4
var building2 = 2

var oxygen = 0

func _on_tick_timeout():
	var oxygenOld = oxygen
	oxygen = building1 * 0.002 - building2 * 0.003
	if oxygen != oxygenOld:
		sphereShrinkRate = sphereShrinkRate + oxygen
	
	var scaleBefore = sphere.scale	
	var scaleAfter = scaleBefore * Vector3(sphereShrinkRate, sphereShrinkRate, sphereShrinkRate)
	sphere.scale = scaleAfter
	
	var sphereArea = sphere.scale.x * sphereInitialRadius * sphereInitialRadius * PI
	scores.text = "Bubble Area: " + str(round(sphereArea)) + "m²" + str((oxygen))
	
	
	
	
