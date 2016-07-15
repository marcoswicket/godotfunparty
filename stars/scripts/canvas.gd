extends CanvasLayer

var star = preload("res://star.scn")


func _on_stars_exit_tree():
	create_stars()
	pass 

func create_stars():
	for i in range(3000):
		randomize()
		var s = star.instance()
		add_child(s)

func _input(event):
	if(event.type == InputEvent.KEY):
		if(event.scancode == KEY_RIGHT):
			get_tree().call_group(0, "star", "set_mode", 1)
		elif(event.scancode == KEY_UP):
			get_tree().call_group(0, "star", "set_mode", 2)
		elif(event.scancode == KEY_LEFT):
			get_tree().call_group(0, "star", "set_mode", 3)
		elif(event.scancode == KEY_DOWN):
			get_tree().call_group(0, "star", "set_mode", 4)
	if(event.type == InputEvent.MOUSE_BUTTON):
		get_tree().call_group(0, "star", "set_mode", 6)

func _ready():
	set_process_input(true)
	print(OS.get_window_size())
	pass


