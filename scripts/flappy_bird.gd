extends Node2D

@export var gravity : float = 500
@export var flap_height : float = 200

@onready var sprite: Sprite2D = $Sprite2D

var velocity : float = 0

func _process(delta: float) -> void:
	
	# on input, have the bird flap
	if Input.is_action_just_pressed("flap"):
		velocity = -flap_height
		
		# tilt up on flap
		rotation_degrees = -45
	
	# create artificial gravity
	# y is flipped compared to normal graphs
	position.y += velocity * delta
	velocity += gravity * delta
	
	# tilt downward
	if velocity > 0:
		rotation_degrees = lerpf(rotation_degrees, 90, 0.02)
