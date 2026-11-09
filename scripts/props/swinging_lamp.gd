class_name SwingingLamp
extends Node3D

## Classic P.T. / SOMA swinging light bulb with dynamic cast shadows

@export var swing_speed: float = 1.2
@export var swing_angle: float = 12.0
@export var flicker_chance: float = 0.04

@onready var light_pivot: Node3D = $Hinge
@onready var omni_light: OmniLight3D = $Hinge/LightBulb/OmniLight3D

var time_passed: float = 0.0

func _process(delta: float) -> void:
	time_passed += delta * swing_speed
	if light_pivot:
		# Double pendulum subtle swing
		var rot_x = sin(time_passed) * deg_to_rad(swing_angle)
		var rot_z = cos(time_passed * 0.7) * deg_to_rad(swing_angle * 0.4)
		light_pivot.rotation.x = rot_x
		light_pivot.rotation.z = rot_z

	# Subtle erratic electrical flicker
	if omni_light and randf() < flicker_chance:
		omni_light.light_energy = randf_range(0.2, 1.4)
	elif omni_light:
		omni_light.light_energy = lerp(omni_light.light_energy, 1.0, delta * 5.0)

