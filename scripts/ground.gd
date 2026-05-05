extends Node2D

@onready var texture_rect: TextureRect = $TextureRect

func _process(delta: float) -> void:
	texture_rect.material.set_shader_parameter("delta", delta)
