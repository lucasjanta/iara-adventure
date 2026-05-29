extends CharacterBody2D

@export var speed := 150.0
@export var jump_force := 1.0
@export var atk_range := 10.0
@export var dmg := 10.0
@export var defense := 0.0
@export var jump_cd := 4.0
@export var jump_bounces := 1.0

func _physics_process(delta: float) -> void:
	move_and_slide()
