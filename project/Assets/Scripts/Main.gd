extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Player_Viewport.size = get_viewport().size
	$Portal_Planes.size = get_viewport().size
	set_process(true)
	
func _process(delta):
	$Screen.material.set_shader_param("mask", $Player_Viewport/Player/Mask.texture)
	var count : int = $Portal_Planes.get_child_count()
	var n = 0
	for i in range(count):
		var node = $Portal_Planes.get_child(i)
		var count_children = node.get_child_count()
		for j in range(count_children):
			var child = node.get_child(j)
			if child is Sprite:
				n = n + 1
				$Screen.material.set_shader_param("blending"+str(n), child.texture)
			if n == 18:
				break
		if n == 18:
			break
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	$Player_Viewport.input(event)
	if event.is_pressed() && event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _on_Player_Camer_Moved(camera):
	for node in $Portal_Planes.get_children():
		node.UpdateCamera(camera)
