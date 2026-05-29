extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var dir: Vector2 = Vector2.ZERO
var next_dir := Vector2.DOWN

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()

func physics_update(delta):
	
	dir = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	if dir == Vector2.ZERO:
		player.velocity = Vector2.ZERO
		state_machine.change_state(state_machine.get_node("IdleState"))
		return
	
	if Input.is_action_just_pressed("jump"):
		$"../JumpState".dir = dir
		state_machine.change_state(state_machine.get_node("JumpState"))
		return
		
	dir = dir.normalized()
	
	player.velocity = dir * player.speed
	player.move_and_slide()
	update_animation(dir)
	
	if dir != Vector2.ZERO:
		next_dir = dir

func update_animation(direction: Vector2):
	var anim := "Run_Down"

	# Diagonais
	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "Run_Up_Side"
				animated_sprite_2d.flip_h = false
			else:
				anim = "Run_Up_Side"
				animated_sprite_2d.flip_h = true
		else:
			if direction.x > 0:
				anim = "Run_Down_Side"
				animated_sprite_2d.flip_h = false
			else:
				anim = "Run_Down_Side"
				animated_sprite_2d.flip_h = true

	# Horizontal
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "Run_Side"
			animated_sprite_2d.flip_h = false
		else:
			anim = "Run_Side"
			animated_sprite_2d.flip_h = true

	# Vertical
	else:
		if direction.y < 0:
			anim = "Run_Up"
		else:
			anim = "Run_Down"

	animated_sprite_2d.play(anim)

func exit():
	$"../IdleState".dir = next_dir
	print("go to idle")
