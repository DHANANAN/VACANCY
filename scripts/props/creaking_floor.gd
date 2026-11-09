class_name CreakingFloor
extends Area3D

## Story Element: Creaking floorboard trigger (inspired by P.T. & SOMA)

@export var creak_sound: AudioStream
@export var trigger_cooldown: float = 3.0
var can_trigger: bool = true

@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if not audio_player:
		audio_player = AudioStreamPlayer3D.new()
		audio_player.name = "AudioStreamPlayer3D"
		audio_player.unit_size = 4.0
		audio_player.max_distance = 12.0
		add_child(audio_player)

func _on_body_entered(body: Node3D) -> void:
	if body is Player and can_trigger:
		can_trigger = false
		if audio_player and audio_player.stream:
			audio_player.pitch_scale = randf_range(0.9, 1.1)
			audio_player.play()
		await get_tree().create_timer(trigger_cooldown).timeout
		can_trigger = true
