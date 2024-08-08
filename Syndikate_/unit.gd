class_name base_unit extends CharacterBody2D

var dir
var gravity = 980
#states
var current_state = 0
enum {WALK, ATTACK, HURT}
var start_state = true

#hit
var hit = false

@onready var anim = $AnimatedSprite2D
@onready var atk_range = $Attack_range
@onready var atk_dmg = $Attack_damage
@export var health = 150
@export var damage = 10
@export var price = 50
@export var enemy : bool
 
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	atk_dmg.body_entered.connect(on_attack_damage_body_entered)
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
	
#States
func walk_state(delta):
	pass
func attack_state(delta):
	pass
func hurting_state(delta):
	pass
func on_attack_damage_body_entered():
	pass
	
func on_attack_range_body_entered():
	pass

func on_attack_range_body_exited():
	pass
