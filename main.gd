extends Node

@onready var sphere = $Sphere
@onready var tick = $Tick
@onready var scoresLabel = $UI/Scores
@onready var timeLabel = $UI/Time
@onready var menuTitle = $Menu/Title
@onready var menuStartButton = $Menu/StartButton


func _ready() -> void:
	$UI.visible = false
	tick.stop()
	
func _on_start_button_pressed():
	$UI.visible = true
	$Menu.visible = false
	tick.start()

func _on_tick_timeout():
	var oxygenOld = Globals.oxygen
	Globals.oxygen = Globals.building1 * 0.002 - Globals.building2 * 0.003
	if Globals.oxygen != oxygenOld:
		Globals.sphereShrinkRate = Globals.sphereShrinkRate + Globals.oxygen
	
	var scaleBefore = sphere.scale	
	var scaleAfter = scaleBefore * Vector3(Globals.sphereShrinkRate, Globals.sphereShrinkRate, Globals.sphereShrinkRate)
	sphere.scale = scaleAfter
	
	var sphereCurrentRadius = sphere.scale.x * Globals.sphereInitialRadius
	var sphereArea = sphereCurrentRadius * sphereCurrentRadius * PI
	scoresLabel.text = "Bubble Area: " + str(round(sphereArea)) + "m²" + str((Globals.oxygen))
	
	if (sphereCurrentRadius > Globals.sphereMaxRadius || sphereCurrentRadius < Globals.sphereMinRadius) :
		# game over
		$Sun.light_color = Color(1, 0, 0, 1)
		sphere.visible = false # insert bubble explosion here
		tick.stop()
		$UI.visible = false
		$Menu.visible = true
	else: 	
		Globals.time += 0.1
		var timeRad = (Globals.time / Globals.cycleTime) * 2 * PI 
		$Sun.position = Vector3(-1 * cos(timeRad) * 100, cos(timeRad) * 100, 0) # position moves in circle around z axis
		$Sun.rotation = Vector3(-1 * cos(timeRad), PI / 2, 0) # rotation moves from noon (top down) to sunset (from left) and so on
		$Sun.light_color = Color(1, 1, cos(timeRad), 1)
		timeLabel.text = "Time of Day: " + str((12 + int(round((Globals.time / Globals.cycleTime) * 24))) % 24)
