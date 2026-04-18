extends CharacterBody2D


const SPEED = 10
const JUMP_VELOCITY = -650.0
var direction = 0
var can_jump = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$Pets.play("slime_fall")
	if direction == 0 and can_jump == false:
		velocity.x = 0
		$Pets.play("slime_idle")
	elif direction < 0 and can_jump == false:
		velocity.x = -SPEED
		$Pets.flip_h = true
		$Pets.play("slime_walk")
		if $Pets.frame == 0 or $Pets.frame == 7 or $Pets.frame == 1:
			velocity.x = 0
	elif direction > 0 and can_jump == false:
		velocity.x = SPEED
		$Pets.flip_h = false
		$Pets.play("slime_walk")
		if $Pets.frame == 0 or $Pets.frame == 7 or $Pets.frame == 1:
			velocity.x = 0
			
	if is_on_floor() and can_jump == true:
		velocity.y = JUMP_VELOCITY
		$Pets.play("slime_jump")
		can_jump = false
		
	move_and_slide()


func _on_timer_timeout() -> void:
	var rand = randi_range(-1, 1)
	direction = rand
	print(direction)


func _on_jump_timer_timeout() -> void:
	var jump = randi_range(5, 5)
	if jump == 5:
		can_jump = true
		print("JUMP")
		
