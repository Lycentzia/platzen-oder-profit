extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var zoomSpeed = Vector3(0,0.5,0.5)
	
	if Input.is_action_just_released('Scroll Up'):
		position += zoomSpeed
	
	if Input.is_action_just_released("Scroll down"):
		position -= zoomSpeed
	pass
