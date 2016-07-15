
extends Node2D

# POSITION AND MOVEMENT VARIABLES
var pos = Vector2(0, 0)
var posOrigin = pos
var size = Vector2(0, 0)
var radius = 0.0
var radiusMax = radius
var angle = 0.0
var sum = 0.0
var angleInc = 0.0
var acc = 0.0
var speed = 0.0
var speedX = 0.0
var speedY = 0.0
var dirX = 1
var dirY = 1


# COLOR AND AESTHETIC VARIABLES
var corr = rand_range(0.0, 1.0)
var corg = corr
var corb = rand_range(corr, 1.0)
var alpha = 0.0
var alphaSpeed = rand_range(0.0, 0.008)
var alphaMode = true

# SELECTING MODE FOR MOVEMENT
# 0 FOR REGULAR SPIN MOVEMENT
# 1 FOR DROP RIGHT
# 2 FOR DROP UP
# 3 FOR DROP LEFT
# 4 FOR DROP DOWN
# 5 TO RETURN
var mode = 0

var windowSize = OS.get_window_size()

func updateAlpha():
	alpha += alphaSpeed
	if(alpha <= 0.0):
		alphaSpeed *= -1
		alpha = 0.0
	elif(alpha >= 1.0):
		alpha = 1
		alphaSpeed *= -1
	alpha += alphaSpeed

func _draw():
	draw_rect(Rect2(pos, size), Color(corr, corg, corb, alpha))

func modeZero():
	angle += angleInc
	var x = radius * cos(angle) + posOrigin.x
	var y = radius * sin(angle) + posOrigin.y
	if(angle >= 360):
		angle = 360
		angleInc *= -1
	elif(angle <= 0):
		angle = 0
		angleInc *= -1
		
	radius += sum
	if(radius <= 0):
		sum *= -1
		radius = 0
		if(rand_range(0, 2) >= 1):
			angleInc *= -1
	elif(radius >= radiusMax):
		sum *= -1
		radius = radiusMax
		if(rand_range(0, 2) >= 1):
			angleInc *= -1
	pos = Vector2(x, y)

func modeRight():
	if(pos.x < windowSize.x - size.x):
		speed += acc
		pos.x += speed
	elif(pos.x > windowSize.x - size.x):
		speed = 0
		pos.x = windowSize.x - size.x
		mode = 5
		
func modeUp():
	if(pos.y > size.y):
		speed += acc
		pos.y -= speed
	elif(pos.y < size.y):
		speed = 0
		pos.y = 0
		mode = 5
		
func modeLeft():
	if(pos.x > size.x):
		speed += acc
		pos.x -= speed
	elif(pos.x < size.x):
		speed = 0
		pos.x = 0
		mode = 5
		
func modeDown():
	if(pos.y < windowSize.y - size.y):
		speed += acc
		pos.y += speed
	elif(pos.y > windowSize.y - size.y):
		speed = 0
		pos.y = windowSize.y - size.y
		mode = 5
		
func modeReturn():
	speedX += acc * dirX
	speedY += acc * dirY
	pos += Vector2(speedX, speedY)
	if(pos.x == posOrigin.x && pos.y == posOrigin.Y):
		mode = 0
	
func _process(delta):
	if(mode == 0):
		modeZero()
	if(mode == 1):
		modeRight()
	if(mode == 2):
		modeUp()
	if(mode == 3):
		modeLeft()
	if(mode == 4):
		modeDown()
	if(mode == 6):
		acc = rand_range(0.25, 0.8)
		# adjusting directions
		if(pos.x > posOrigin.x):
			dirX = -1
		elif(pos.x < posOrigin.x):
			dirX = 1
		elif(pos.x == posOrigin.x):
			dirX = 0
		if(pos.y > posOrigin.y):
			dirY = -1
		elif(pos.y < posOrigin.y):
			dirY = 1
		elif(pos.y == posOrigin.y):
			dirY = 0
		modeReturn()
		
	updateAlpha()
	update()

func set_mode(n):
	if(n == 6):
		if(mode == 5):
			mode = n
	else:
		mode = n

func _ready():
	var s = rand_range(0, 5)
	size = Vector2(s, s)
	
	sum = rand_range(0.0, 0.08)
	angleInc = rand_range(0.0, 0.01)
	
	radius = rand_range(0.0, 25.0)
	radiusMax = radius
	
	pos = Vector2(rand_range(radius, windowSize.x - radius), rand_range(radius, windowSize.y - radius))
	posOrigin = pos
	
	if(rand_range(0, 2) >= 1):
		angleInc *= -1
	
	if(corb < 0.4):
		corb = rand_range(0.4, 0.7)
	if(corr < 0.4):
		corb = rand_range(corr, 0.5)
		
	acc = rand_range(0.1, 0.25)
	
	add_to_group("star")
	
	set_process(true)
	
	pass


