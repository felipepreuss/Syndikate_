class_name hammer_unit extends red_unit

func walk_state(delta):
	move(80)
	$hp_label.text = str(health)+str(" hp Walking...")
	atk_dmg.monitoring = true
	atk_range.monitoring = true
	if die:
		set_state(DIE)
	if hit:
		set_state(HURT)
