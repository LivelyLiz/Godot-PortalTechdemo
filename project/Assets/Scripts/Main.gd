extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_pressed() && event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _process(delta):
	pass

func _on_Player_Camer_Moved(camera_transform, position):
	$Rendering_Test.Update_Cameras(camera_transform, position)
