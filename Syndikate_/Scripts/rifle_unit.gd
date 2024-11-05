class_name rifle_unit extends pistol_unit

@onready var RIFLE_BULLET = preload("res://Scenes/rifle_bala.tscn")

func attack_state(delta):
	move(0)
	$AnimatedSprite2D.play("default")
	$hp_label.text = str(health)+str(" hp Attacking!!")
	var bullet = RIFLE_BULLET.instantiate()
	if $AnimatedSprite2D.frame == 2:
		if pode_atirar:
			bullet.global_position = $bullet_marker.global_position
			get_parent().add_child(bullet)
			pode_atirar = false
		elif !pode_atirar:
			await get_tree().create_timer(1).timeout
			pode_atirar = true
	if die:
		set_state(DIE)
	if hit:
		set_state(HURT)
