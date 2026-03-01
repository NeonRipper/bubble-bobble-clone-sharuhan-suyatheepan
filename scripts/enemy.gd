extends CharacterBody2D

@export var speed := 100.0
@export var gravity := 900.0
enum State { ACTIVE, TRAPPED }
var state = State.ACTIVE


var direction := -1

func _physics_process(delta):
	if state == State.TRAPPED:
		velocity = Vector2.ZERO
		return

	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = direction * speed
	
	move_and_slide()
	
	if is_on_wall():
		direction *= -1
