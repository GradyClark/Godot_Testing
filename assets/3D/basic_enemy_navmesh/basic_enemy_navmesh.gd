extends KinematicBody

var path = []
var path_node = 0

var speed = 5

onready var nav: Navigation = get_parent()
onready var player = $"../../Player"

var death_anim_played = false

func _physics_process(delta):
	if $destroyable.is_dead:
		if !death_anim_played:
			if is_instance_valid(player):
	#			var target_position = Vector3(-10, -10, -10)
				var new_transform = transform.looking_at(player.transform.origin, Vector3.UP)
	#			print(new_transform)
	#			var new_transform = transform
				
				new_transform = new_transform.rotated(Vector3(0, 0, 1), 4)
				
				transform  = transform.interpolate_with(new_transform, .5 * delta)			
				
	#			print(rotation_degrees.z)
				if rotation_degrees.z <= -90:
					death_anim_played = true
			else:
				death_anim_played = true
				player = null
			
	else:
		if player != null and path_node < path.size():
			var direction = (path[path_node] - global_transform.origin)
			if direction.length() < 1:
				path_node += 1
			else:
				move_and_slide(direction.normalized() * speed, Vector3.UP)


func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0


func _on_Timer_timeout():
	if player != null and !is_instance_valid(player):
		player = null
		
	if player != null:
		move_to(player.global_transform.origin)


func _on_destroyable_on_death():
#	rotate_x(90)
#	rotate_z(90)
	pass


func _on_Area_body_entered(body):
	if body.is_in_group("destroyable"):
		var info = body.get_node("destroyable")
		info.change_health_by(-10)
