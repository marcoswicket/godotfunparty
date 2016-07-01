
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var pos = Vector2(0, 0)
var radius = rand_range(0.0, 200.0)
var radiusMax = radius
var angle = 0
var sum = rand_range(0.0, 1.0)
var angleInc = rand_range(0.0, 0.05)
var posOrigin = pos
var size = Vector2(5, 5)

var corr = rand_range(0.0, 1.0)
var corg = corr
var corb = 0.0
var alpha = 1.0
var alphaSpeed = rand_range(0.0, 0.05)
var alphaMode = true;

var corSpeed = rand_range(0.0, 0.12) * -1

func changecolor():
	alpha -= alphaSpeed
	if(alpha > 1.0):
		alphaSpeed *= -1
	elif(alpha < 0.0):
		alphaSpeed *= -1
	
	"""corb = corb + corSpeed
	if(corb < 0.5):
		corSpeed = corSpeed * -1
		corb = 0.5
	elif(corb > 1.0):
		corSpeed = corSpeed * -1
		corb = 1.0"""


func _draw():
	draw_rect(Rect2(pos, size), Color(corr, corg, corb, alpha))
	#draw_rect(Rect2(posOrigin, size), Color(255, 255, 255))
	#print("R: ", corr, " G: ", corg, " B: ", corb)
	pass
	
func _process(delta):
	angle += angleInc
	var x = radius * cos(angle) + posOrigin.x
	var y = radius * sin(angle) + posOrigin.y
	if (angle > 360):
		angleInc *= -1
	if(angle < 0):
		angleInc *= -1
	
	radius = radius + sum
	if(radius < 0):
		sum = sum * -1
		radius += sum
		randomize()
		var op = rand_range(0, 2)
		if(op > 1):
			angleInc *= -1
	elif(radius > radiusMax):
		sum = sum * -1
		radius += sum
		randomize()
		var op = rand_range(0, 2)
		if(op > 1):
			angleInc *= -1
	pos = Vector2(x, y)
	#print("angleInc: ", angleInc, " sum: ", sum, " radius: ", radius, " y: ", y, " radiusMax: ", radiusMax, " alphaSpeed: ", alphaSpeed, " alpha: ", alpha) 
	changecolor()
	update()
	
	
func _ready():
	randomize()
	var windowSize = OS.get_window_size()
	pos = Vector2(rand_range(0.0, windowSize.x), rand_range(0.0, windowSize.y))
	posOrigin = pos
	radius = rand_range(0.0, 200.0)
	sum = rand_range(0.0, 0.5)
	angleInc = rand_range(0.0, 0.01)
	
	#check bounds to see if the star will spin out of the screen and correct it
	if(radius + posOrigin.x > windowSize.x || radius + posOrigin.y > windowSize.y):
		radius = min((windowSize.x - posOrigin.x), (windowSize.y - posOrigin.y))
	if(posOrigin.x - radius < 0 || posOrigin.y - radius < 0):
		radius = min(posOrigin.x, posOrigin.y)
	
	radiusMax = radius
	
	#give a blueish feel to the star
	if(corr > 0.4):
		corb = 1
	else:
		corb = rand_range(corr, corr+0.1)
	
	set_process(true)
	pass


