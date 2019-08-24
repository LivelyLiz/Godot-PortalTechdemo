extends Spatial

export(int) var res_x = 512
export(int) var res_y = 512
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	$Plane1/Viewport.size.x = res_x
	$Plane1/Viewport.size.y = res_y
	$Plane2/Viewport.size.x = res_x
	$Plane2/Viewport.size.y = res_y

func Update_Cameras(camera_transform, position):
	var plane1_pos = $Plane1.to_local(position)
	var plane2_pos = $Plane2.to_local(position)
	$Plane1/Viewport/Camera.transform.basis = camera_transform.basis
	$Plane2/Viewport/Camera.transform.basis = camera_transform.basis
	$Plane1/Viewport/Camera.translation = plane2_pos
	$Plane2/Viewport/Camera.translation = plane1_pos
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
