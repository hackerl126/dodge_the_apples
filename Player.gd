extends Area2D

signal hit

var speed = 300
var screen_size

var upDOWN=false
var downDOWN=false
var leftDOWN=false
var rightDOWN=false
var shootDOWN=false

var loadbullet=preload("res://Bullet.tscn")
var startshoot=true


func _ready():
	self.body_entered.connect(_on_Player_body_entered)
	$ShootTimer.timeout.connect(_on_ShootTimer_timeout)
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if  rightDOWN==true:
		velocity.x += 1
		
	if leftDOWN==true:
		velocity.x -= 1
		
	if downDOWN==true:
		velocity.y += 1

	if upDOWN==true:
		velocity.y -= 1
		

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


	if (shootDOWN==true) and startshoot:
		shoot()
		startshoot=false
		$ShootTimer.start()


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(_body):
	
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)


func shoot():
	var bullet=Global.instance_node(loadbullet,self.global_position,Global.world,global_rotation)
	startshoot=false
	$ShootTimer.start()


func _on_HUD_UpUp():
	upDOWN=false


func _on_HUD_UpDown():
	upDOWN=true


func _on_HUD_DownUp():
	downDOWN=false


func _on_HUD_DownDown():
	downDOWN=true




func _on_HUD_RightUp():
	rightDOWN=false


func _on_HUD_LeftDown():
	leftDOWN=true


func _on_HUD_LeftUp():
	leftDOWN=false


func _on_HUD_RightDown():
	rightDOWN=true


func _on_ShootTimer_timeout():
	startshoot=true


func _on_HUD_ShootDown():
	shootDOWN=true





func _on_HUD_ShootUp():
	shootDOWN=false
