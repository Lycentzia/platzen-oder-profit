extends Node

@onready var sphere = $Sphere
@onready var tick = $Tick
@onready var scoresLabel = $UI/Scores
@onready var timeLabel = $UI/Time
@onready var menuTitle = $Menu/Title
@onready var menuStartButton = $Menu/StartButton
@onready var buildingsPlacer = $BuildingsPlacer


func _ready() -> void:
	Globals.reset()
	$UI.visible = false
	tick.stop()
	
func _on_start_button_pressed():
	Globals.reset()
	buildingsPlacer.reset()
	sphere.scale = Vector3(1,1,1)
	var sphereMeshAnimationPlacer: AnimationPlayer = sphere.get_node("MeshInstance3D/AnimationPlayer")
	sphereMeshAnimationPlacer.queue("RESET")
	sphere.visible = true
	$UI.visible = true
	$Menu.visible = false
	tick.start()

func _on_tick_timeout():
	var oxygenOld = Globals.oxygen
	Globals.oxygen = Globals.building1 * 0.0029 - Globals.building2 * 0.003
	if Globals.oxygen != oxygenOld:
		Globals.sphereChangeRate = Globals.sphereShrinkRate + Globals.oxygen
	
	var scaleBefore = sphere.scale	
	var scaleAfter = scaleBefore * Vector3(Globals.sphereChangeRate, Globals.sphereChangeRate, Globals.sphereChangeRate)
	sphere.scale = scaleAfter
	
	var sphereCurrentRadius = sphere.scale.x * Globals.sphereInitialRadius
	var sphereArea = sphereCurrentRadius * sphereCurrentRadius * PI
	scoresLabel.text = "Bubble Area: " + str(round(sphereArea)) + "m²"
	
	Globals.money = Globals.money + Globals.building1 * 0.003 - Globals.building2 * 0.002
	Globals.money = snapped(Globals.money * 1.0001,0.001)
	scoresLabel.text = scoresLabel.text + " | " + str("%.3f" % Globals.money) + "₿"
	
	if (sphereCurrentRadius > Globals.sphereMaxRadius || sphereCurrentRadius < Globals.sphereMinRadius || Globals.money < 0) :
		# game over
		$Sun.light_color = Color(1, 0, 0, 1)
		sphere.destroyBubble()
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

func _on_add_building(index: int):
	if (index == 0):
		Globals.building1 += 1
		Globals.money -= 0.2
	elif (index == 1):
		Globals.building2 += 1
		Globals.money -= 0.2
