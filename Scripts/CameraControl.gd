extends Node3D

@export var movement_speed = 5.0
@export var zoom_speed = 10.0
@export var rotation_speed = 50.0

var pivot_distance = 5.0
var plane_y = 0.0

var camera: Camera3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = $Camera3D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handleMovement(delta)
	handleZoom(delta)
	handleRotation(delta)
pass

func handleMovement(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed('ui_up'):
		direction += Vector3.FORWARD
	if Input.is_action_pressed('ui_down'):
		direction -= Vector3.FORWARD
	if Input.is_action_pressed('ui_left'):
		direction -= Vector3.RIGHT
	if Input.is_action_pressed('ui_right'):
		direction += Vector3.RIGHT

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		global_transform.origin += global_transform.basis * direction * movement_speed * delta
pass

func handleZoom(delta):
	var mouse_wheel_motion = Input.get_action_strength('camera_zoom_out') - Input.get_action_strength('camera_zoom_in')
	if mouse_wheel_motion != 0:
		camera.translate(Vector3(0, 0, zoom_speed * mouse_wheel_motion * delta))
pass

func handleRotation(delta):
	if Input.is_action_pressed('rotate_left'):
		rotate_y(deg_to_rad(rotation_speed * delta))
	if Input.is_action_pressed('rotate_right'):
		rotate_y(deg_to_rad(-rotation_speed * delta))
pass
