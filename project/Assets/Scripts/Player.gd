extends KinematicBody

signal Camer_Moved(camera)

var camera_angle = 0
var mouse_sens = 0.3
var velocity = Vector3()
var direction = Vector3()

# Walk variables
var gravity = -9.8 * 3
var MAX_SPEED = 10
const ACCEL = 10
const DEACCEL = 10

func _ready():
	var size = get_viewport().size
	$Body/Head/Second_Camera_Image.size = size
	$Mask.region_rect.size = size
	$Mask.offset = size / 2
	$Body.size = size
	$Player_View.region_rect.size = size
	$Player_View.offset = size/2

func _physics_process(delta):
	walk(delta)

func walk(delta):
	direction = Vector3()

	var aim = $Body/Head/Camera.global_transform.basis
	if Input.is_action_pressed("ui_up"):
		direction -= aim.z
	if Input.is_action_pressed("ui_down"):
		direction += aim.z
	if Input.is_action_pressed("ui_left"):
		direction -= aim.x
	if Input.is_action_pressed("ui_right"):
		direction += aim.x

	direction = direction.normalized()
	#velocity.y += gravity * delta

	var temp_velocity = velocity
	temp_velocity.y = 0

	var speed = MAX_SPEED
	var target = direction * speed
	var acceleration
	if direction.dot(temp_velocity) > 0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL

	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z

	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	camera_moved()

func camera_moved():
	emit_signal("Camer_Moved",$Body/Head/Camera)

func _input(event):
	$Body/Head/Second_Camera_Image.input(event)
	$Body.input(event)
	if event is InputEventMouseMotion:
		#Body/Head.rotate_y(deg2rad(-event.relative.x * mouse_sens))
		#rotate_y(deg2rad(-event.relative.x * mouse_sens))
		rotate_object_local(Vector3(0,1,0), deg2rad(-event.relative.x * mouse_sens))
		
		var change = -event.relative.y * mouse_sens
		if change + camera_angle < 90 && change + camera_angle > -90:
			$Body/Head/Camera.rotate_x(deg2rad(change))
			camera_angle += change
		camera_moved()