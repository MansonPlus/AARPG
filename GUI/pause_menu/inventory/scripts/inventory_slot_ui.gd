class_name InventorySlotUI extends Button

var slot_data: SlotData: set = set_slot_data

@onready var texture_rect = $TextureRect
@onready var label = $Label

func _ready():
	texture_rect.texture = null
	label.text = ""
	focus_entered.connect(item_focused)
	focus_exited.connect(item_unfocused)

func set_slot_data(value: SlotData):
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)

func item_focused():
	if slot_data != null:
		if slot_data.item_data != null:
			PauseMenu.update_item_description(slot_data.item_data.description)
	
func item_unfocused():
	PauseMenu.update_item_description("")
	pass
