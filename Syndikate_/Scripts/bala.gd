class_name bala extends Area2D
var vel = 4
var dir = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += vel * dir
	
	
func _on_body_entered(body):
	if body.is_in_group("white_units"):
		body.hurt(40)
		queue_free()
