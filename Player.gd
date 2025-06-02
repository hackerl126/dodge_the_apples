extends Area2D

signal hit

var speed = 300
var screen_size

var up=false
var down=false
var left=false
var right=false
var shooting=false

var loadbullet=preload("res://Bullet.tscn")
var startshoot=true

func _ready():
	get_node("../HUD/Control").control_pressed.connect(_on_control_pressed)
	get_node("../HUD/Control").control_released.connect(_on_control_released)
	self.body_entered.connect(_on_Player_body_entered)
	$ShootTimer.timeout.connect(_on_ShootTimer_timeout)
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2.ZERO
	if  right==true:
		velocity.x += 1
		
	if left==true:
		velocity.x -= 1
		
	if down==true:
		velocity.y += 1
	if up==true:
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if (shooting==true) and startshoot:
		shoot()
		startshoot=false
		$ShootTimer.start()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func shoot():
	var bullet=Global.instance_node(loadbullet,self.global_position,Global.world,global_rotation)
	startshoot=false
	$ShootTimer.start()

func _on_ShootTimer_timeout():
	startshoot=true

func _on_control_pressed(name):
	if name == "up":
		up = true
	if name == "down":
		down = true
	if name == "left":
		left = true
	if name == "right":
		right = true
	if name == "shoot":
		shooting = true

func _on_control_released(name):
	if name == "up":
		up = false
	if name == "down":
		down = false
	if name == "left":
		left = false
	if name == "right":
		right = false
	if name == "shoot":
		shooting = false
