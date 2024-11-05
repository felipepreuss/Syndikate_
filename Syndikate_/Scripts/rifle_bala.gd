class_name rifle_bala extends bala

func _on_body_entered(body):
	if body.is_in_group("white_units"):
		body.hurt(25)
		queue_free()
