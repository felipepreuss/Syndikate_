class_name red_unit extends base_unit

func attack_state(delta):
	move(0)
	$hp_label.text = str(health)+str(" hp Attacking!!")
	atk_dmg.monitoring = false
	atk_range.monitoring = false
	await get_tree().create_timer(0.5).timeout
	if die:
		set_state(DIE)
	elif hit:
		set_state(HURT)
	else:
		set_state(KNOCKBACK)
func on_attack_damage_body_entered(body):
	if body.is_in_group("white_units"):
		attack_range = true
		set_state(ATTACK)
		body.hurt(damage)
		print("R Attack_dmg entered.")
func on_attack_damage_body_exited(body):
	if body.is_in_group("white_units"):
		attack_range = false
		print("R Attack_dmg exited.")
func on_attack_range_body_entered(body):
	if body.is_in_group("white_units"):
		detect_player = true
		print("R Attack_range entered.")
func on_attack_range_body_exited(body):
	if body.is_in_group("white_units"):
		detect_player = false
		print("R Attack_range exited.")
