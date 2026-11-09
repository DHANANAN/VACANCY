class_name CrtTelevision
extends Interactable

## Story Beat: A television that turns itself on, emitting blue static and low whispers.

@export var is_turned_on: bool = true
@onready var screen_mesh: MeshInstance3D = $ScreenMesh
@onready var tv_light: OmniLight3D = $OmniLight3D

func _ready() -> void:
	prompt_message = "Turn Off TV" if is_turned_on else "Turn On TV"
	_update_tv_state()

func _update_tv_state() -> void:
	if screen_mesh:
		screen_mesh.visible = is_turned_on
	if tv_light:
		tv_light.visible = is_turned_on

func _on_interacted(_player: Node3D) -> void:
	is_turned_on = !is_turned_on
	prompt_message = "Turn Off TV" if is_turned_on else "Turn On TV"
	_update_tv_state()
	
	if GameManager:
		if is_turned_on:
			GameManager.show_subtitle("The static hums... faint muffled murmurs underneath, like people talking in another room.", 4.0)
		else:
			GameManager.show_subtitle("Click. Silence returns to the living room.", 2.5)

