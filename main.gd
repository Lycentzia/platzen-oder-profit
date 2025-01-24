extends Node

@onready var sphere = $Sphere
@onready var scores = $UI/Scores

var sphereInitialRadius = 10 # how to get this programmatically?
var sphereShrinkRate = 0.999

func _on_tick_timeout():
	var scaleBefore = sphere.scale	
	var scaleAfter = scaleBefore * Vector3(sphereShrinkRate, sphereShrinkRate, sphereShrinkRate)
	sphere.scale = scaleAfter
	
	var sphereArea = sphere.scale.x * sphereInitialRadius * sphereInitialRadius * PI
	scores.text = "Bubble Area: " + str(round(sphereArea)) + "m²"
