class_name white_unit extends base_unit

func walk_state(delta):
	move(-100)
	$hp_label.text = str(health)+str(" hp Walking...")
	atk_dmg.monitoring = true
	atk_range.monitoring = true
	if hit:
		set_state(HURT)
	if die:
		set_state(DIE)

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
func knockback_state(delta):
	if die:
		set_state(DIE)
	$hp_label.text = str(health)+str(" hp Knockback!")
	await get_tree().create_timer(0.4).timeout
	move(300)
	await get_tree().create_timer(0.4).timeout
	set_state(WALK)
func on_attack_damage_body_entered(body):
	if body.is_in_group("red_units"):
		attack_range = true
		set_state(ATTACK)
		body.hurt(damage)
		print("W Attack_dmg: body entered.")
func on_attack_damage_body_exited(body):
	if body.is_in_group("red_units"):
		attack_range = false
		print("W Attack_dmg exited.")
func on_attack_range_body_entered(body):
	if body.is_in_group("red_units"):
		detect_player = true
		print("W Attack_range entered.")
func on_attack_range_body_exited(body):
	if body.is_in_group("red_units"):
		detect_player = false
		print("W Attack_range: exited.")
