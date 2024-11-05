class_name pistol_unit extends base_unit
var pode_atirar = false
@onready var BULLET = preload("res://Scenes/bala.tscn")

func _ready():
	atk_range.body_entered.connect(on_attack_range_body_entered)
	atk_range.body_exited.connect(on_attack_range_body_exited)

func walk_state(delta):
	move(100)
	$hp_label.text = str(health)+str(" hp Walking...")
	atk_range.monitoring = true
	if die:
		set_state(DIE)
	if hit:
		set_state(HURT)

func attack_state(delta):
	move(0)
	$AnimatedSprite2D.play("default")
	$hp_label.text = str(health)+str(" hp Attacking!!")
	var bullet = BULLET.instantiate()
	if $AnimatedSprite2D.frame == 2:
		if pode_atirar:
			bullet.global_position = $bullet_marker.global_position
			get_parent().add_child(bullet)
			pode_atirar = false
		elif !pode_atirar:
			await get_tree().create_timer(0.5).timeout
			pode_atirar = true
	if die:
		set_state(DIE)
	if hit:
		set_state(HURT)

func on_attack_range_body_entered(body):
	if body.is_in_group("white_units"):
		set_state(ATTACK)
		pode_atirar = true
		print("R Attack_range entered.")
func on_attack_range_body_exited(body):
	if body.is_in_group("white_units"):
		set_state(WALK)
		print("R Attack_range exited.")
