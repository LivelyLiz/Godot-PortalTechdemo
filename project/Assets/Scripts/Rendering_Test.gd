extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	$Plane1/Viewport.size = get_viewport().size
	$Plane2/Viewport.size = get_viewport().size
	$Sprite.region_rect.size = get_viewport().size
	$Sprite.offset = get_viewport().size / 2

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


func _on_Plane1_Visible_Notifier_screen_entered():
	if !$Plane2/Plane2_Visible_Notifier.is_on_screen():
		$Sprite.texture = $Plane1/Viewport.get_texture()

func _on_Plane2_Visible_Notifier_screen_entered():
	if !$Plane1/Plane1_Visible_Notifier.is_on_screen():
		$Sprite.texture = $Plane2/Viewport.get_texture()
