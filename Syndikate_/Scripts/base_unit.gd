class_name base_unit extends CharacterBody2D

# fabbri eu te detesto muito, pqp não faz um codigo direeito - felipe
var dir = 1
var gravity = 980
#states
var current_state = 0
enum {WALK, ATTACK, HURT, DIE, KNOCKBACK}
var start_state = true
#hit
var hit = false
var die = false
var detect_player = false
var attack_range = false

@onready var anim = $AnimatedSprite2D
@onready var atk_range = $Attack_range
@onready var atk_dmg = $Attack_damage
@export var health = 50
@export var damage = 25
@export var price = 50
@export var enemy : bool
 


# Called when the node enters the scene tree for the first time.
func _ready():
	
	atk_dmg.body_entered.connect(on_attack_damage_body_entered)
	atk_dmg.body_exited.connect(on_attack_damage_body_exited)
	atk_range.body_entered.connect(on_attack_range_body_entered)
	atk_range.body_exited.connect(on_attack_range_body_exited) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match current_state:
		WALK:
			walk_state(delta)
		ATTACK:
			attack_state(delta)
		HURT:
			hurting_state(delta)
		DIE:
			die_state(delta)
		KNOCKBACK:
			knockback_state(delta)
func set_state(new_state):
	if new_state != current_state:
		current_state = new_state
		start_state = true
		hit = false

#States
func walk_state(delta):
	move(100)
	$hp_label.text = str(health)+str(" hp Walking...")
	atk_dmg.monitoring = true
	atk_range.monitoring = true
	if die:
		set_state(DIE)
	if hit:
		set_state(HURT)
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
func hurting_state(delta):
	move(0)
	$hp_label.text = str(health)+str(" hp Hurting!")
	atk_dmg.monitoring = false
	atk_range.monitoring = false
	if die:
		set_state(DIE)
	else:
		set_state(KNOCKBACK)

func die_state(delta):
	$hp_label.text = "0 hp Dead ;-;"
	await get_tree().create_timer(0.3).timeout
	queue_free()

func knockback_state(delta):
	if die:
		set_state(DIE)
	$hp_label.text = str(health)+str(" hp Knockback!")
	await get_tree().create_timer(0.4).timeout
	move(-300)
	await get_tree().create_timer(0.4).timeout
	set_state(WALK)

func hurt(damage):
	health -= damage
	print(health)
	if health > 0:
		hit = true
	elif health <= 0:
		die = true

func move(speed = 0, can_fall = true, delta = 0):
	if dir: 
		if dir == 1:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		velocity.x = speed * dir
	move_and_slide()
 
func on_attack_damage_body_entered(body):
		attack_range = true
		print("Attack_dmg entered.")
func on_attack_damage_body_exited(body):
		attack_range = false
		print("Attack_dmg exited.")
func on_attack_range_body_entered(body):
		detect_player = true
		print("Attack_range entered.")
func on_attack_range_body_exited(body):
		detect_player = false
		print("Attack_range exited.")
