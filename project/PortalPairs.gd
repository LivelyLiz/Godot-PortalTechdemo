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
	
	$Portal1_VP/Sprite.region_rect.size = vp_size
	$Portal2_VP/Sprite.region_rect.size = vp_size
	
	$Portal1_VP/Sprite.offset = vp_size/2
	$Portal2_VP/Sprite.offset = vp_size/2
	
	findPortals()

func findPortals():
	_portal1 = $Portal1 as TeleportTestPlane
	_portal2 = $Portal2 as TeleportTestPlane
	
	_portal1._exit_portal = _portal2
	_portal2._exit_portal = _portal1
	
	_portal1.index = Portal1_Index
	_portal2.index = Portal2_Index







