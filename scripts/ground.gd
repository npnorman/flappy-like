extends Node2D

@export var scroll_speed: float = 50
var screen_width: float

@onready var texture1 = $Texture1
@onready var texture2 = $Texture2

func _ready():
	screen_width = get_viewport().get_visible_rect().size.x
	# Place texture2 directly to the right of texture1
	
	texture1.size.x = screen_width
	texture2.size.x = screen_width
	
	texture2.position.x = screen_width

func _process(delta: float) -> void:
	# Move both left
	texture1.position.x -= scroll_speed * delta
	texture2.position.x -= scroll_speed * delta

	# When texture1 is fully off-screen, wrap it to the right of texture2
	if texture1.position.x <= -screen_width - 50:
		texture1.position.x = texture2.position.x + screen_width + 50

	if texture2.position.x <= -screen_width - 50:
		texture2.position.x = texture1.position.x + screen_width + 50
