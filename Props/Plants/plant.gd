class_name Plant
extends Node2D

@onready var hit_box = $HitBox

func _ready():
	hit_box.damaged.connect(TakeDamage)

func TakeDamage(hurt_box: HurtBox) -> void:
	queue_free()
