extends Area2D

@export var horizontal_speed := 300.0
@export var float_speed := 100.0
@export var float_delay := 0.5
@export var lifetime := 3.5
var trapped_enemy : CharacterBody2D = null

var direction := 1
var time_alive := 0.0
var floating := false

func _physics_process(delta):

	time_alive += delta

	if time_alive >= float_delay:
		floating = true

	if not floating:
		position.x += direction * horizontal_speed * delta
	else:
		position.y -= float_speed * delta


	if time_alive >= lifetime:
		queue_free()
	
	if trapped_enemy!= null:
		trapped_enemy.global_position = global_position



func _on_body_entered(body: Node2D) -> void:
	if trapped_enemy != null:
		return
	
	if body.is_in_group("enemies"):
		trapped_enemy = body
		body.state = body.State.TRAPPED
	pass
	if body.name == "player" and trapped_enemy:
		pop()
func pop():
	trapped_enemy.queue_free()
	get_parent().score += 100
	queue_free()
