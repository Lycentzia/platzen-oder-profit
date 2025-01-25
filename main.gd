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

var sphereInitialRadius = 10 # how to get this programmatically?
var sphereShrinkRate = 0.999
var sphereMaxRadius = 50
var sphereMinRadius = 5

var building1 = 0
var building2 = 2

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
	
	var sphereCurrentRadius = sphere.scale.x * sphereInitialRadius
	var sphereArea = sphereCurrentRadius * sphereCurrentRadius * PI
	scoresLabel.text = "Bubble Area: " + str(round(sphereArea)) + "m²" + str((oxygen))
	
	if (sphereCurrentRadius > sphereMaxRadius || sphereCurrentRadius < sphereMinRadius) :
		# game over
		$Sun.light_color = Color(1, 0, 0, 1)
		sphere.visible = false # insert bubble explosion here
		tick.stop()
		$UI.visible = false
		$Menu.visible = true
	else: 	
		time += 0.1
		var timeRad = (time / cycleTime) * 2 * PI 
		$Sun.position = Vector3(-1 * cos(timeRad) * 100, cos(timeRad) * 100, 0) # position moves in circle around z axis
		$Sun.rotation = Vector3(-1 * cos(timeRad), PI / 2, 0) # rotation moves from noon (top down) to sunset (from left) and so on
		$Sun.light_color = Color(1, 1, cos(timeRad), 1)
		timeLabel.text = "Time of Day: " + str((12 + int(round((time / cycleTime) * 24))) % 24)
