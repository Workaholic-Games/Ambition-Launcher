extends Node3D
var current_positon : int = 1
@export var can_move : bool = true



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left"):
		if can_move == true:
			match current_positon:
				0: pass
				1: 
					$Animation/AnimationPlayer.play("middle_left")
					current_positon = 0
				2: 
					$Animation/AnimationPlayer.play("right_middle")
					current_positon = 1
	
	if Input.is_action_just_pressed("right"):
		if can_move == true:
			match current_positon:
				0: 
					$Animation/AnimationPlayer.play("left_middle")
					current_positon = 1
				1: 
					$Animation/AnimationPlayer.play("middle_right")
					current_positon = 2
				2: pass
