extends RayCast3D

## Casts forward from the player's center view to detect interactive items

@export var prompt_label_path: NodePath
var prompt_label: Label
var current_target: Interactable = null

func _ready() -> void:
	if not prompt_label_path.is_empty():
		prompt_label = get_node_or_null(prompt_label_path)

func _process(_delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider is Interactable and collider.is_usable:
			current_target = collider
			if prompt_label:
				prompt_label.text = "[E] " + current_target.get_prompt()
				prompt_label.visible = true
			return

	current_target = null
	if prompt_label:
		prompt_label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and current_target:
		var player = owner
		current_target.interact(player)

