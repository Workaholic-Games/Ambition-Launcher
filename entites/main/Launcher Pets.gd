extends CharacterBody2D
const SPEED = 10
var JUMP_VELOCITY = randi_range(-650, -400)
var direction = 0
var can_jump = false
var can_grab = false
var grabbed = false
var idle_animation = "slime_idle"
var walk_animation = "slime_walk"
var jump_animation = "slime_jump"



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if direction == 0:
		velocity.x = 0
		$Pets.play(idle_animation)
	elif direction < 0:
		velocity.x = -SPEED
		$Pets.flip_h = true
		$Pets.play(walk_animation)
		if walk_animation == "slime_walk":
			if $Pets.frame == 0 or $Pets.frame == 7 or $Pets.frame == 1:
				velocity.x = 0
			
	elif direction > 0:
		velocity.x = SPEED
		$Pets.flip_h = false
		$Pets.play(walk_animation)
		if walk_animation == "slime_walk":
			if $Pets.frame == 0 or $Pets.frame == 7 or $Pets.frame == 1:
				velocity.x = 0
	if is_on_floor() and can_jump == true:
		velocity.y = JUMP_VELOCITY
		can_jump = false
	
	if grabbed == false:
		move_and_slide()
	
	
	if Input.is_action_pressed("grab") and can_grab == true:
		global_position = get_global_mouse_position()
		velocity = Vector2.ZERO
		grabbed = true
		$Container.scale = Vector2(20.0, 20.0)
	else:
		grabbed = false
		$Container.scale = Vector2(1.0, 1.0)
		
	if Input.is_action_just_pressed("flip") and can_grab == true:
		if direction == 1:
			direction = -1
		elif direction == -1:
			direction = 1
		
		if $Pets.flip_h == false:
			$Pets.flip_h = true
		else:
			$Pets.flip_h = false



func _on_jump_timer_timeout() -> void:
	var jump = randi_range(0, 5)
	if jump == 5:
		can_jump = true


func _on_walk_timer_timeout() -> void:
	var rand = randi_range(-1, 1)
	direction = rand


func _on_slime_button_pressed() -> void:
	idle_animation = "slime_idle"
	walk_animation = "slime_walk"
	jump_animation = "slime_jump"

func _on_square_button_pressed() -> void:
	idle_animation = "square_idle"
	walk_animation = "square_walk"

func _on_snail_button_pressed() -> void:
	idle_animation = "snail_idle"
	walk_animation = "snail_walk"


func _on_blue_guy_button_pressed() -> void:
	idle_animation = "blueguy_idle"
	walk_animation = "blueguy_walk"
	jump_animation = "blueguy_jump"



func _on_container_mouse_entered() -> void:
	can_grab = true
func _on_container_mouse_exited() -> void:
	can_grab = false



func _on_size_value_changed(value: float) -> void:
	scale = Vector2(value, value)
