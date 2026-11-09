class_name ShiftingPictureFrame
extends Interactable

## Story Clue #6: The faces in the photographs change and become Arin's.

@export var inspect_text: String = "An old photograph. Two elderly people and a boy whose face is blurred in motion."
@export var portrait_mesh_path: NodePath
var portrait_mesh: MeshInstance3D

func _ready() -> void:
	prompt_message = "Examine Portrait"
	if not portrait_mesh_path.is_empty():
		portrait_mesh = get_node_or_null(portrait_mesh_path)

func _on_interacted(_player: Node3D) -> void:
	if GameManager:
		GameManager.show_subtitle(inspect_text, 4.0)
		
		# In Night 2 or later, the portrait warps further
		if GameManager.current_night >= GameManager.Night.NIGHT_2:
			inspect_text = "Every photograph holds the same face now... It looks like my own."
