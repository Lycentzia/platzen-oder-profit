extends Node

@onready var sphere = $Sphere

var sphereShrinkRate = 0.999

func _on_tick_timeout():
	var scaleBefore = sphere.scale
	var scaleAfter = scaleBefore * Vector3(sphereShrinkRate, sphereShrinkRate, sphereShrinkRate)
	sphere.scale = scaleAfter
