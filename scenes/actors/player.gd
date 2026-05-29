extends CharacterBody2D

@export var speed := 150.0
@export var jump_force := 100.0
@export var dmg := 10.0

func _physics_process(delta: float) -> void:
	move_and_slide()
