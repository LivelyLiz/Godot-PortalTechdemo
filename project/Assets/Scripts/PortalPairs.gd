extends Spatial

var _portal1 : TeleportTestPlane
var _portal2 : TeleportTestPlane
var _camera1 : Camera 
var _camera2 : Camera 

export(int) var Portal1_Index
export(int) var Portal2_Index

func _ready():
	var vp_size : Vector2 = get_viewport().size
	
	$Portal1_VP.size = vp_size
	$Portal2_VP.size = vp_size
	
	$Portal1_Sprite.region_rect.size = vp_size
	$Portal2_Sprite.region_rect.size = vp_size
	
	$Portal1_Sprite.offset = vp_size/2
	$Portal2_Sprite.offset = vp_size/2
	
	findPortals()

func findPortals():
	_portal1 = $Portal1 as TeleportTestPlane
	_portal2 = $Portal2 as TeleportTestPlane
	
	_camera1 = $Portal1_VP/Camera
	_camera2 = $Portal2_VP/Camera
	
	#_camera1.cull_mask += pow(2, Portal2_Index+1)
	#_camera2.cull_mask += pow(2, Portal1_Index+1)
	
	_portal1._exit_portal = _portal2
	_portal2._exit_portal = _portal1
	
	_portal1.index = Portal1_Index
	_portal2.index = Portal2_Index

func UpdateCamera(camera):
	var position = camera.global_transform.origin
	var camera_transform = camera.global_transform
	var plane1_pos = _portal1.to_local(position)
	var plane2_pos = _portal2.to_local(position)
	
	var one_eighty_rotation = Quat(Vector3(0,1,0), PI)
	var portal1_global_transform = _portal1.global_transform
	var portal2_global_transform = _portal2.global_transform
	
	_camera1.transform.basis = portal2_global_transform.basis * Basis(one_eighty_rotation) * portal1_global_transform.basis.inverse() * camera_transform.basis
	_camera2.transform.basis = portal1_global_transform.basis * Basis(one_eighty_rotation) * portal2_global_transform.basis.inverse() * camera_transform.basis
	_camera1.translation = _portal2.to_global(one_eighty_rotation * plane1_pos)
	_camera2.translation = _portal1.to_global(one_eighty_rotation * plane2_pos)





