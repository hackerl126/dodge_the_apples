extends CanvasLayer

signal start_game

signal UpUp
signal UpDown
signal DownDown
signal DownUp
signal LeftUp
signal LeftDown
signal RightUp
signal RightDown
signal ShootDown
signal ShootUp

signal revive
signal notrevive

func _ready():
	ctrlHide()
	
	$Control.hide()
	$ReviveLabel.hide()
	$NotReviveLabel.hide()
	$ReviveVideo.hide()
	
	$UpLabel/Up.pressed.connect(func(): emit_signal("UpDown"))
	$UpLabel/Up.released.connect(func(): emit_signal("UpUp"))
	$DownLabel/Down.pressed.connect(func(): emit_signal("DownDown"))
	$DownLabel/Down.released.connect(func(): emit_signal("DownUp"))
	$LeftLabel/Left.pressed.connect(func(): emit_signal("LeftDown"))
	$LeftLabel/Left.released.connect(func(): emit_signal("LeftUp"))
	$RightLabel/Right.pressed.connect(func(): emit_signal("RightDown"))
	$RightLabel/Right.released.connect(func(): emit_signal("RightUp"))
	
	$ShootLabel/Shoot.pressed.connect(func(): emit_signal("ShootDown"))
	$ShootLabel/Shoot.released.connect(func(): emit_signal("ShootUp"))
	
	$StartLabel/Start.pressed.connect(_on_Start_pressed)
	$ReviveLabel/Revive.pressed.connect(_on_Revive_pressed)
	$NotReviveLabel/NotRevive.pressed.connect(_on_NotRevive_pressed)
	
	$MessageTimer.timeout.connect(func(): $MessageLabel.hide())

func show_message(text,time):
	$MessageTimer.wait_time=time
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("你被林檎击中力\n（恼）",1)
	ctrlHide()
	
	$Control.hide()
	await $MessageTimer.timeout
	show_message("是否\n看视频复活？",1)
	$MessageTimer.stop()
	$ReviveLabel.show()
	$NotReviveLabel.show()

func restart_game():
	$MessageLabel.text = "躲避林檎"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$StartLabel.show()

func update_score(score):
	$ScoreLabel.text = "分数："+str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func ctrlShow():
	$UpLabel.show()
	$DownLabel.show()
	$LeftLabel.show()
	$RightLabel.show()
	$ShootLabel.show()

func ctrlHide():
	$UpLabel.hide()
	$DownLabel.hide()
	$LeftLabel.hide()
	$RightLabel.hide()
	$ShootLabel.hide()

func _on_Start_pressed():
	emit_signal("start_game")
	$StartLabel.hide()

func _on_Revive_pressed():
	$ReviveLabel.hide()
	$NotReviveLabel.hide()
	$ReviveVideo.show()
	$MessageLabel.hide()
	await playvideo()
	$ReviveVideo.hide()
	emit_signal("revive")

func playvideo():
	$ReviveVideo.play()
	await $ReviveVideo.finished

func _on_NotRevive_pressed():
	emit_signal("notrevive")
	restart_game()
	$ReviveLabel.hide()
	$NotReviveLabel.hide()
