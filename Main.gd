extends Node

var mob_scene:PackedScene=preload("res://Mob.tscn")
var score=0
var revive=false
var mobspeed=150
var windowsize
var curve:Curve2D

func _ready():
	randomize()
	Global.world=self
	windowsize=$StartPosition.get_viewport_rect().size
	
	curve=Curve2D.new()
	curve.add_point(Vector2(0.0,windowsize.y*0.9))
	curve.add_point(Vector2.ZERO)
	curve.add_point(Vector2(windowsize.x,0.0))
	curve.add_point(Vector2(windowsize.x,windowsize.y*0.9))
	$MobPath.curve=curve
	
	$Player.hit.connect(game_over)
	$MobTimer.timeout.connect(_on_MobTimer_timeout)
	$ScoreTimer.timeout.connect(_on_ScoreTimer_timeout)
	$StartTimer.timeout.connect(_on_StartTimer_timeout)
	
	$HUD.start_game.connect(new_game)
	$HUD.revive.connect(_on_HUD_revive)
	$HUD.notrevive.connect(_on_HUD_notrevive)

func _exit_tree():
	Global.world=null

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$ColorRect.color=Color(0.22,0.21,0.13,1)

func new_game():
	get_tree().call_group("mobs", "queue_free")
	if revive==false:
		score=0
		$ScoreTimer.wait_time=1
		$MobTimer.wait_time=1
		$Player/ShootTimer.wait_time=0.5
		mobspeed=150
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	score_update_state()
	$HUD.show_message("3秒准备时间",3)
	$Music.play()
	$HUD.ctrlShow()
	$HUD/Control.show()

func _on_MobTimer_timeout():
	add_mob()
	if(score>=50):
		add_mob()
		if(score>=100):
			add_mob()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	score_update_state()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func add_mob():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress = randi()
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(mobspeed,(mobspeed+100)), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func score_update_state():
	if(score>=20 and score<30):
		$ColorRect.color.r=0.6
	if(score>=20):
		mobspeed=clamp(mobspeed+15,10,2000)
		$Player/ShootTimer.wait_time=0.2
	if(score>=50):
		$MobTimer.wait_time=clamp($MobTimer.wait_time-0.05,0.1,1)
		$ScoreTimer.wait_time=0.6
		$Player/ShootTimer.wait_time=0.15
	if(score>=100):
		$ScoreTimer.wait_time=0.3

func _on_HUD_revive():
	revive=true
	new_game()

func _on_HUD_notrevive():
	revive=false

func change_background_color():
	if(score>=30):
		$ColorRect.color=Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),randf_range(0,1))
