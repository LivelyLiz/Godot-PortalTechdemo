extends Spatial

class_name TeleportTestPlane

var _exit_portal : Spatial = null

export(float) var teleportationDist = 0.1

var index : int = -1 setget setIndex, getIndex

var _player : Spatial = null
var _portalShape : BoxShape = null
var _prev_locPlayerPos : Vector3 = Vector3()

func _ready():
	find_player()
	if(_player == null):
		print("No player")
		set_physics_process(false)
	find_shape()

func setIndex(newValue : int):
	index = newValue
	
	var m : SpatialMaterial = SpatialMaterial.new()
	m.albedo_color = Color(index/255.0, 0, 0, 1)
	m.flags_unshaded = true
	$Plane.set_surface_material(0, m)
	$Plane.layers = pow(2, index+1)
	
	

func getIndex():
	return index

#find the player in the scene
func find_player():
	_player = get_tree().get_root().find_node("Player", true, false)

#find the portal area's shape
func find_shape():
	_portalShape = $Area/CollisionShape.shape as BoxShape

func _physics_process(delta):
	if(checkTeleportArea()):
		teleport(_player)

#Check if a teleport needs to occur
func checkTeleportArea():
	var curr_locPlayerPos : Vector3 = to_local(_player.global_transform.origin)
	if(canTeleport(curr_locPlayerPos)):
		print("prev local %", _prev_locPlayerPos)
		_prev_locPlayerPos = curr_locPlayerPos
		return true
	else:
		_prev_locPlayerPos = curr_locPlayerPos
		return false

#Can the player teleport?
#pos: position in this portals local space
func canTeleport(pos : Vector3):
	return pos.z < 0 \
		&& pos.z > -teleportationDist \
		&& _prev_locPlayerPos.z > 0 \
		&& abs(pos.x) <= _portalShape.extents.x \
		&& pos.y >= 0 && pos.y <= 2 * _portalShape.extents.y

#teleport player from this portal to the exit portal
func teleport(targetObject : Spatial):
	
	var targetObjRot : Spatial = targetObject.find_node("Body").find_node("Head") #need head for rotation
	
	#local position for this portal
	var tO_this_locPos : Vector3 = to_local(targetObject.global_transform.origin)
	
	#exit position
	var tO_exit_locPos : Vector3 = tO_this_locPos
	tO_exit_locPos.x = -tO_exit_locPos.x #flip x axis -> exit on the same relative spot
	tO_exit_locPos.z = -tO_exit_locPos.z #flip z axis -> move in front of the portal
	
	#rotation based on
	var locRot : float = acos(clamp(targetObjRot.global_transform.basis.z.dot(global_transform.basis.z), -1, 1))
	if(targetObjRot.global_transform.basis.z.dot(global_transform.basis.x) < 0):
		locRot = 2*PI - locRot
	
	var tO_this_locRot : Basis = Basis(Quat(Vector3(0, 1, 0), locRot))
	var y180_rot : Basis = (Quat(Vector3(0,1,0), PI))
	var newBasis : Basis = y180_rot * tO_this_locRot * _exit_portal.global_transform.basis
	newBasis = newBasis.orthonormalized()
	
	targetObject.velocity = newBasis * targetObject.velocity #avoid the kinematic body to accidentally go back into the exit portal
	
	print("curr local %", tO_this_locPos)
	print("exit local %", tO_exit_locPos)
	
	#targetObject.global_transform.origin = _exit_portal.to_global(tO_exit_locPos)
	targetObject.global_transform.origin = _exit_portal.to_global(tO_exit_locPos)
	targetObjRot.global_transform.basis = newBasis






