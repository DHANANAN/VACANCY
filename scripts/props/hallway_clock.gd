class_name HallwayClock
extends Interactable

## Story Rule #8: The Uncanny Toolkit: A clock stuck at 3:07 that still ticks.

func _ready() -> void:
	prompt_message = "Examine Clock"

func _on_interacted(_player: Node3D) -> void:
	if GameManager:
		GameManager.show_subtitle("The clock hands are frozen at 3:07. Yet the rhythmic ticking persists.", 4.0)
