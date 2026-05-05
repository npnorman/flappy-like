extends Node2D

# The goal of this file is to generate pipes and scroll then

@onready var pipe_spawn_timer: Timer = $pipeSpawnTimer

@export var camera : Camera2D
@export var pipe_scene : PackedScene
@export var gap : float = 150
@export var speed : float = 100

var pipe_pairs : Array[PipePair] = [] # list of pipe pairs

func get_random_height():
	
	var rng = RandomNumberGenerator.new()
	var random_height = rng.randf_range(
		-get_viewport_rect().size.x/2 + 100,
		get_viewport_rect().size.x/2 - 100)
	
	return random_height

func initialize_pipe_pair(gap, speed):
	var screen_center : Vector2 = camera.get_screen_center_position()
	var screen_width : float = get_viewport_rect().size.x
	
	var height = get_random_height()
	
	var new_pair : PipePair = PipePair.new(self, screen_center, screen_width, gap, speed, height)
	pipe_pairs.append(new_pair)

func _ready() -> void:
	initialize_pipe_pair(gap, speed)
	pipe_spawn_timer.start()

func _process(delta: float) -> void:
	# for each pipe pair
	for i in range(0, len(pipe_pairs)):
		pipe_pairs[i].move_pipe(delta)
	
	# get rid of first one
	if pipe_pairs[0].get_position().x <= 0 - 50:
		pipe_pairs[0].custom_free()
		pipe_pairs.remove_at(0)

func _on_pipe_spawn_timer_timeout() -> void:
	initialize_pipe_pair(gap, speed)
