extends Camera3D

@export var speed : float = 1.0

func _process(delta):
	var movement = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		movement += Vector3.FORWARD
	if Input.is_action_pressed("move_back"):
		movement += Vector3.BACK
	if Input.is_action_pressed("move_left"):
		movement += Vector3.LEFT
	if Input.is_action_pressed("move_right"):
		movement += Vector3.RIGHT
	if Input.is_action_pressed("move_up"):
		movement += Vector3.UP
	if Input.is_action_pressed("move_down"):
		movement += Vector3.DOWN
	translate(movement * delta)
