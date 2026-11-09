class_name Interactable
extends CollisionObject3D

## Base class for interactive objects in VACANCY (doors, pill bottles, notes, phone, kettle)

signal interacted(player: Node3D)

@export var prompt_message: String = "Inspect"
@export var is_usable: bool = true

func get_prompt() -> String:
	return prompt_message

func interact(player: Node3D) -> void:
	if not is_usable:
		return
	interacted.emit(player)
	_on_interacted(player)

func _on_interacted(_player: Node3D) -> void:
	# Override in subclass or connect to interacted signal
	pass

