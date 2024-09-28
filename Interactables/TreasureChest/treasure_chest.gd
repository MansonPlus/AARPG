@tool
class_name TreasureChest extends Node2D

@export var item_data: ItemData: set = _set_item_data
@export var quantity: int = 1 : set = _set_quantity

var is_open: bool = false

@onready var sprite: Sprite2D = $ItemSprite
@onready var label: Label = $ItemSprite/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $Area2D

func _ready():
	_update_texture()
	_update_label()
	if Engine.is_editor_hint():
		return
	interact_area.area_entered.connect(_on_area_entered)
	interact_area.area_exited.connect(_on_area_exited)

func player_interact():
	if is_open == true:
		return
	is_open = true
	animation_player.play("open_chest")
	if item_data && quantity > 0:
		PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
	else:
		printerr("No Items in Chest")
		push_error("No Items in Chest Chest Name: ", name)

func _on_area_entered(_a: Area2D):
	PlayerManager.interact_pressed.connect(player_interact)

func _on_area_exited(_a: Area2D):
	PlayerManager.interact_pressed.disconnect(player_interact)

func _set_item_data(value: ItemData):
	item_data = value
	_update_texture()

func _set_quantity(value: int):
	quantity = value
	_update_label()

func _update_texture():
	if item_data && sprite:
		sprite.texture = item_data.texture

func _update_label():
	if label:
		if quantity <= 1:
			label.text = ""
		else:
			label.text = "x" + str(quantity)
