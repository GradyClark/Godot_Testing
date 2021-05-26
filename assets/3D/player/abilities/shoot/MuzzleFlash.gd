extends Spatial

export (SpatialMaterial) var flash_animation_material

# .8 55 42
func _ready():
	$Flash.set_surface_material(0, flash_animation_material)
	var material = $Flash.get_surface_material(0)

	$Tween.interpolate_property(material, "albedo_color", Color(0, 0, 0, 0.01), Color(0, 0, 0, 0), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property(material, "emission", Color(0.93, 0.9, 0.89), Color(0.88, 0.55, 0.45), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property(material, "emission_energy", 10, 0, 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.interpolate_property($Flash, "scale", Vector3(1, 1, 1), Vector3(0.3, 0.3, 0.3), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	
func _on_Lifetime_timeout():
	queue_free()
