
extends Area2D

var window_size = OS.get_window_size()

func _draw():
	draw_line(Vector2(0, (window_size.y/2)), Vector2(window_size.x, (window_size.y/2)), Color(255, 0, 0), 1)
	draw_line(Vector2(window_size.x/2, 0), Vector2(window_size.x/2, window_size.y), Color(255, 0, 0), 1)
func _ready():
	set_process(true)
	
	pass



