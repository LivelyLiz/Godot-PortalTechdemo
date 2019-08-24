extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var node = null setget set_node_path
var _exit_portal : Spatial = null

export(float) var teleportationDist = 0.001

var _player : Spatial = null
var _prev_locPlayerPos : Vector3 = Vector3()

func set_node_path(path):
	node = path
	if is_inside_tree():
		_update_node_field()

func _update_node_field():
	if node != null:
		var n = get_node(node)
		if (n is Spatial):
			_exit_portal = n
		else:
			print("Error: the node must be Spatial!")
			node = null
	else:
		_exit_portal = null


func _ready():
	_update_node_field()
	find_player()
	if(_player == null):
		print("No player")
		set_physics_process(false)
	
func find_player():
	_player = get_tree().get_root().find_node("Player", true, false)
	print(get_tree().get_root().print_tree_pretty())
	
func _physics_process(delta):
	if(checkTeleportArea()):
		teleport(_player)
		
func checkTeleportArea():
	var curr_locPlayerPos : Vector3 = to_local(_player.global_transform.origin)
	if(curr_locPlayerPos.z < 0 && _prev_locPlayerPos.z > 0):
		return true
	else:
		_prev_locPlayerPos = curr_locPlayerPos
		return false

func teleport(targetObject : Spatial):
	
	var tO_this_locPos : Vector3 = to_local(targetObject.global_transform.origin)
	
	var tO_exit_locPos : Vector3 = tO_this_locPos
	tO_exit_locPos.x = -tO_exit_locPos.x
	
	targetObject.global_transform.origin = _exit_portal.to_global(tO_exit_locPos)








