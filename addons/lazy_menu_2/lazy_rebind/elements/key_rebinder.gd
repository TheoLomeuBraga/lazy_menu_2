extends LazyRebind
class_name LazyRebindElement


@export var key_rebind_type : LazyRebindBuilder.KeyRebindTypes

var action : String

static func remove_actions_types_from(action : String,type : LazyRebindBuilder.KeyRebindTypes) -> void:
	for b in InputMap.action_get_events(action):
		match type:
			LazyRebindBuilder.KeyRebindTypes.Keyboard:
				if b is InputEventKey:
					InputMap.action_erase_event(action,b)
					
			LazyRebindBuilder.KeyRebindTypes.Joystick:
				if b is InputEventJoypadButton or b is InputEventJoypadMotion:
					InputMap.action_erase_event(action,b)
					

static var is_rebinding : bool = false

func  start_rebind() -> void:
	if is_rebinding == false:
		is_rebinding = true
		set_process_input(true)

func  stop_rebind() -> void:
	is_rebinding = false
	set_process_input(false)

func update_button_text() -> void:
	
	if InputMap.action_get_events(action).size() > 0:
		
		var input_event : InputEvent = null
		
		for i in InputMap.action_get_events(action):
			if key_rebind_type == LazyRebindBuilder.KeyRebindTypes.Keyboard and i is InputEventKey:
				input_event = i
			elif key_rebind_type == LazyRebindBuilder.KeyRebindTypes.Joystick and (i is InputEventJoypadButton or i is InputEventJoypadMotion):
				input_event = i
		
		if input_event != null:
			
			if input_event is InputEventKey:
				get_node("VBoxContainer/HBoxContainer/Button").text = input_event.as_text().split(" ")[0]
			elif input_event is InputEventJoypadButton:
				var names : PackedStringArray = input_event.as_text().split(" ")
				var key_display_name : String
				for i in range(3,names.size()):
					key_display_name += names[i] + " "
				
				
				get_node("VBoxContainer/HBoxContainer/Button").text = key_display_name.erase(key_display_name.length() - 2,2).erase(0)
				
			elif input_event is InputEventJoypadMotion:
				var names : PackedStringArray = input_event.as_text().split(" ")
				var key_display_name : String
				for i in range(5,min(names.size(),11)):
					key_display_name += names[i] + " "
				
				get_node("VBoxContainer/HBoxContainer/Button").text = key_display_name.erase(key_display_name.length() - 2,2).erase(0)

func _ready() -> void:
	set_process_input(false)
	$VBoxContainer/HBoxContainer/Button.pressed.connect(start_rebind)
	
	update_button_text()

func check_joystick_motion_is_valid(event : InputEventJoypadMotion) -> bool:
	
	
	
	if abs(event.axis_value) > 0.8:
		return true
	
	return false

func _input(event: InputEvent) -> void:
	match key_rebind_type:
		LazyRebindBuilder.KeyRebindTypes.Keyboard:
			if event is InputEventKey:
				
				remove_actions_types_from(action,LazyRebindBuilder.KeyRebindTypes.Keyboard)
				InputMap.action_add_event(action,event)
				
				stop_rebind()
				update_button_text()
				
		LazyRebindBuilder.KeyRebindTypes.Joystick:
			if event is InputEventJoypadButton:
				
				remove_actions_types_from(action,LazyRebindBuilder.KeyRebindTypes.Joystick)
				InputMap.action_add_event(action,event)
				
				stop_rebind()
				update_button_text()
			
			
			elif event is InputEventJoypadMotion:
				remove_actions_types_from(action,LazyRebindBuilder.KeyRebindTypes.Joystick)
				
				if not check_joystick_motion_is_valid(event):
					return
					
				if event.axis_value > 0:
					event.axis_value = 1
				elif event.axis_value < 0:
					event.axis_value = -1
				InputMap.action_add_event(action,event)
				
				stop_rebind()
				update_button_text()
			
		
	
	
	
