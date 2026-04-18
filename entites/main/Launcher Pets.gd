extends CharacterBody2D


const SPEED = 10
var JUMP_VELOCITY = randi_range(-650.0, -400)
var direction = 0
var can_jump = false
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
		if $Pets.frame == 0 or $Pets.frame == 7 or $Pets.frame == 1:
			velocity.x = 0
	elif direction > 0:
		velocity.x = SPEED
		$Pets.flip_h = false
		$Pets.play(walk_animation)
		if $Pets.frame == 0 or $Pets.frame == 7 or $Pets.frame == 1:
			velocity.x = 0
	if is_on_floor() and can_jump == true:
		velocity.y = JUMP_VELOCITY
		can_jump = false
		
	move_and_slide()

func _on_jump_timer_timeout() -> void:
	var jump = randi_range(0, 5)
	if jump == 5:
		can_jump = true
		print("JUMP")


func _on_walk_timer_timeout() -> void:
	var rand = randi_range(-1, 1)
	direction = rand
	print(direction)


func _on_slime_button_pressed() -> void:
	idle_animation = "slime_idle"
	walk_animation = "slime_walk"
	jump_animation = "slime_jump"


func _on_square_button_pressed() -> void:
	idle_animation = "square_idle"
