extends CharacterBody2D

@export var sprite_2D: Sprite2D
@export var max_health := 3
var health := max_health

var speed = 25
var player_chase = false
var player = null


func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position) / speed
		move_and_collide(Vector2(0,0))
		
		if (player.position.x - position.x) < 0:
			sprite_2D.flip_h = false
		else:
			sprite_2D.flip_h = true

func take_damage(amount: int) -> void:
	health -= amount
	print("knight took " + str(amount) + " damage")
	
	if health <= 0:
		queue_free()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	print("body entered")
	
func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	print("body exited")
