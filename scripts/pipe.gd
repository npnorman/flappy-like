extends Node2D

@onready var stalk: Sprite2D = $stalk
@onready var end: Sprite2D = $end

func flip_sprites():
	stalk.flip_h = true
	end.flip_h = true
	end.flip_v = true
