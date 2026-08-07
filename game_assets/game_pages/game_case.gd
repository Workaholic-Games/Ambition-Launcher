extends Node3D
@export var game : GameData
@export var camera : Camera3D
var rotating : bool = false
var open : bool = false
var hovering : bool = false
var can_open : bool = true


## NEED VARIABLE TO AVOID SPAM OPENING/CLOSING

func _ready() -> void:
	$Case.rotate_y(-45.0)
	
	$Case/Offset/Cover.texture = game.hinge
	$Case/Offset/Front/Cover.texture = game.cover
	$Case/Offset/Back/Back.texture = game.back
	
	$Case/Offset/Back/CD.material_override.albedo_texture = game.disc

func _input(event):
	if Input.is_action_just_pressed("grab"):
		if can_open == false:
			return
		
		open = !open
		can_open = false
		if open == true:
			$Case/AnimationPlayer.play("open")
			$Open.play(0.06)
		else:
			$Case/AnimationPlayer.play("close")
			await get_tree().create_timer(0.25).timeout
			$Close.play()
	
	if Input.is_action_just_pressed("scroll_up"):
		camera.fov = clamp(camera.fov - 2, 60, 100)
	if Input.is_action_just_pressed("scroll_down"):
		camera.fov = clamp(camera.fov + 2, 60, 100)
	
	if Input.is_action_pressed("rotate"):
		if event is InputEventMouseMotion:
			var delta = get_process_delta_time()
			var relative = event.relative
			
			$Case.rotate_y(relative.x * 5 * delta)

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("q"):
		$Case/Offset/Back/CD.rotation_degrees.z += 5
		$Case/Offset/Back/CD.rotation_degrees.z = wrap($Case/Offset/Back/CD.rotation_degrees.z, 0, 360)
	
	if Input.is_action_pressed("e"):
		$Case/Offset/Back/CD.rotation_degrees.z -= 5
		$Case/Offset/Back/CD.rotation_degrees.z = wrap($Case/Offset/Back/CD.rotation_degrees.z, 0, 360)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	can_open = true
