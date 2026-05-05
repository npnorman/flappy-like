extends Node2D

# The goal of this file is to generate pipes and scroll then

@onready var pipe_spawn_timer: Timer = $pipeSpawnTimer

@export var camera : Camera2D
@export var pipe : PackedScene
@export var gap : float = 150
@export var speed : float = 100

var pipe_pairs = [] # list of pipe pairs

func generate_pipe_pair():
	# generate 2 pipes
	# get the middle of the screen and generate a pipe
	var screen_center : Vector2 = camera.get_screen_center_position()
	var screen_width : float = get_viewport_rect().size.x
	
	var initial_position : Vector2 = screen_center
	initial_position.x += (screen_width / 2) + 50 # offset to go a little beyond half way

	# spawn in a pipe at this position
	var top_pipe : Node2D = pipe.instantiate()
	add_child(top_pipe)
	top_pipe.position = initial_position
	
	var bottom_pipe : Node2D = pipe.instantiate()
	add_child(bottom_pipe)
	bottom_pipe.position = initial_position
	bottom_pipe.rotation_degrees = 180
	bottom_pipe.flip_sprites()
	
	return [top_pipe, bottom_pipe]

func set_gap(gap:float, pipe_pair):
	pipe_pair[0].position.y -= gap / 2
	pipe_pair[1].position.y += gap / 2

func move_pipes(speed:float, pipe_pair):
	pipe_pair[0].position.x -= speed
	pipe_pair[1].position.x -= speed

func _ready() -> void:
	pipe_pairs.append(generate_pipe_pair())
	set_gap(gap, pipe_pairs[0])
	
	pipe_spawn_timer.start()

func _process(delta: float) -> void:
	# for each pipe pair
	for pipe_pair in pipe_pairs:
		move_pipes(speed * delta, pipe_pair)

func _on_pipe_spawn_timer_timeout() -> void:
	pipe_pairs.append(generate_pipe_pair())
	set_gap(gap, pipe_pairs[-1])
