extends Spatial

var enemy_resource = preload("res://assets/3D/basic_enemy_navmesh/basic_enemy_navmesh.tscn")

var enemy_spawn = null


func _ready():
	$Navigation/NavigationMeshInstance.visible=false
	
	enemy_spawn = $Navigation/enemy.transform


func _on_Timer_timeout():
	var e2 = enemy_resource.instance()
	$Navigation.add_child(e2)
