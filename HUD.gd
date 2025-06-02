extends CanvasLayer

signal start_game
signal revive
signal notrevive

func _ready():
	$Control.hide()
	$ReviveLabel.hide()
	$NotReviveLabel.hide()
	$ReviveVideo.hide()
	
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
