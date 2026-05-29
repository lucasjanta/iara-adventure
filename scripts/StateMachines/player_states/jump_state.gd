extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var jump_circle: AnimatedSprite2D = $"../../jumpCircle"

var dir: Vector2 = Vector2.ZERO
var next_dir := Vector2.DOWN
var jump_total_duration : float = 0.0
var jump_duration : float = 0.0

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	jump_circle.visible = true
	jump_circle.speed_scale = 1.0 / player.jump_force
	jump_circle.play("default")
	update_animation()
	jump_duration = player.jump_force
	jump_total_duration = player.jump_force

func physics_update(delta):
	
	dir = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	
	
	#if dir == Vector2.ZERO:
		#player.velocity = Vector2.ZERO
		#state_machine.change_state(state_machine.get_node("IdleState"))
		#return
	#
	#if Input.is_action_just_pressed("jump"):
		#$"../JumpState".dir = dir
		#state_machine.change_state(state_machine.get_node("JumpState"))
		#return
		
	dir = dir.normalized()
	
	player.velocity = dir * player.speed
	player.move_and_slide()
	
	
	if dir != Vector2.ZERO:
		next_dir = dir
		
	if jump_duration > 0.0:
		jump_duration -= delta
	else:
		state_machine.change_state(state_machine.get_node("IdleState"))
		return
		
	if jump_duration > jump_total_duration / 2:
		animated_sprite_2d.offset.y -= player.atk_range * 3 * delta
	else:
		animated_sprite_2d.offset.y += player.atk_range * 3 * delta

func update_animation():
	animated_sprite_2d.play("Jump_Down")


		

func exit():
	$"../IdleState".dir = next_dir
	animated_sprite_2d.offset.y = 0
	jump_circle.visible = false
