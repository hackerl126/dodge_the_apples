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
	$Label7.hide()
	$Label8.hide()
	$ReviveVideo.hide()

func show_message(text,time):
	$MessageTimer.wait_time=time
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("你被林檎击中力\n（恼）",1)
	ctrlHide()
	await $MessageTimer.timeout
	show_message("是否\n看视频复活？",1)
	$MessageTimer.stop()
	$Label7.show()
	$Label8.show()



func restart_game():
	$MessageLabel.text = "躲避林檎"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$Label6.show()


func update_score(score):
	$ScoreLabel.text = "分数："+str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	


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



func _on_Up_pressed():
	emit_signal("UpDown")


func _on_Up_released():
	emit_signal("UpUp")


func _on_Down_pressed():
	emit_signal("DownDown")


func _on_Down_released():
	emit_signal("DownUp")


func _on_Left_pressed():
	emit_signal("LeftDown")


func _on_Left_released():
	emit_signal("LeftUp")


func _on_Right_pressed():
	emit_signal("RightDown")


func _on_Right_released():
	emit_signal("RightUp")


func _on_Shoot_pressed():
	emit_signal("ShootDown")


func _on_Shoot_released():
	emit_signal("ShootUp")


func _on_Start_pressed():
	emit_signal("start_game")
	$Label6.hide()


func _on_Revive_pressed():
	$Label7.hide()
	$Label8.hide()
	$ReviveVideo.show()
	$MessageLabel.hide()
	await playvideo()
	$ReviveVideo.hide()
	emit_signal("revive")


func playvideo():

	$ReviveVideo.play()
	await get_tree().create_timer(10).timeout



func _on_NotRevive_pressed():
	emit_signal("notrevive")
	restart_game()
	$Label7.hide()
	$Label8.hide()
