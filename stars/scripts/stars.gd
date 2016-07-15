extends Label

var op = 0.0
var opRate = 0.01
var startFlag = false

func _input(event):
	if(event.is_action("start")):
		startFlag = true
		print(startFlag)
	
func _unhandled_input(event):
	print("notWorking")

func _process(delta):
	op += opRate
	set_opacity(op)
	if(op >= 1):
		op = 1
		opRate *= -1
	elif(op <= 0):
		op = 0
		opRate *= -1
		if(startFlag):
			set_process(not startFlag)
			queue_free()

func _ready():
	var pos = OS.get_window_size() / 2
	pos.x -= get_size().x / 2
	pos.y -= get_size().y / 2
	set_pos(pos)
	set_opacity(0.0)
	set_process(true)
	set_process_input(true)
	
	pass

