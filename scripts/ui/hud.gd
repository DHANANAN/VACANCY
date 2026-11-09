class_name GameHUD
extends Control

@onready var subtitle_label: Label = $SubtitleContainer/SubtitleLabel
@onready var subtitle_container: Control = $SubtitleContainer
@onready var vignette: ColorRect = $VignetteOverlay

var subtitle_tween: Tween

func _ready() -> void:
	subtitle_container.modulate.a = 0.0
	if GameManager:
		GameManager.subtitle_requested.connect(_on_subtitle_requested)
		GameManager.episode_started.connect(_on_episode_started)
		GameManager.episode_subsided.connect(_on_episode_subsided)

func _on_subtitle_requested(text: String, duration: float) -> void:
	if subtitle_tween:
		subtitle_tween.kill()
	
	subtitle_label.text = text
	subtitle_tween = create_tween()
	subtitle_tween.tween_property(subtitle_container, "modulate:a", 1.0, 0.4)
	subtitle_tween.tween_interval(duration)
	subtitle_tween.tween_property(subtitle_container, "modulate:a", 0.0, 0.6)

func _on_episode_started(intensity: float) -> void:
	if vignette:
		var tw = create_tween()
		tw.tween_property(vignette, "modulate:a", clamp(intensity, 0.0, 0.8), 1.0)

func _on_episode_subsided() -> void:
	if vignette:
		var tw = create_tween()
		tw.tween_property(vignette, "modulate:a", 0.0, 1.2)

