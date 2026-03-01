extends CharacterBody2D

@export var speed := 200.0
@export var jump_velocity := -500.0
@export var gravity := 900.0
@export var bubble_scene : PackedScene   

var facing := 1  

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	if direction != 0:
		facing = direction

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_just_pressed("fire"):
		shoot()

	move_and_slide()


func shoot():
	if bubble_scene == null:
		return
	var b = bubble_scene.instantiate()
	b.global_position = global_position + Vector2(30 * facing, 0)
	b.direction = facing
	get_parent().add_child(b)
