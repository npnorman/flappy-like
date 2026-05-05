extends Node
class_name PipePair

var pipe_scene = preload("uid://dlsw5f4njvw3t")

@export var top_pipe : Pipe
@export var bottom_pipe : Pipe
@export var gap : float
@export var height : float
@export var speed : float

func set_gap():
	top_pipe.position.y -= gap / 2
	bottom_pipe.position.y += gap / 2

func set_height():
	top_pipe.position.y += height
	bottom_pipe.position.y += height

func move_pipe(delta):
	top_pipe.position.x -= speed * delta
	bottom_pipe.position.x -= speed * delta

func get_position():
	return top_pipe.position

func _init(current_scene:Node2D, screen_center : Vector2, screen_width, gap, speed, height=0):
	var initial_position : Vector2 = screen_center
	initial_position.x += (screen_width / 2) + 50 # offset to go a little beyond half way

	# spawn in a pipe at this position
	top_pipe = pipe_scene.instantiate()
	current_scene.add_child(top_pipe)
	top_pipe.position = initial_position
	
	bottom_pipe = pipe_scene.instantiate()
	current_scene.add_child(bottom_pipe)
	bottom_pipe.position = initial_position
	bottom_pipe.rotation_degrees = 180
	bottom_pipe.flip_sprites()
	
	self.gap = gap
	self.speed = speed
	self.height = height
	
	set_gap()
	set_height()

func custom_free():
	top_pipe.queue_free()
	bottom_pipe.queue_free()
	self.queue_free()
