class_name InventoryData extends Resource

@export var slots: Array[SlotData]

func _init():
	connect_slots()

func add_item(item: ItemData, count: int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				s.quantity += count
				return true
	
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[i] = new
			new.changed.connect(slot_changed)
			return true
	
	print("Inventory was full!")
	
	return false

func connect_slots():
	for s in slots:
		if s:
			s.changed.connect(slot_changed)

func slot_changed():
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)	
				var index = slots.find(s)
				slots[index] = null
				emit_changed()
