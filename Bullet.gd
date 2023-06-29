extends Area2D



var velocity=Vector2(0,-1)
var speed=2000

func _process(delta):
	global_position += velocity.rotated(rotation)*speed*delta


func _on_visibility_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("mobs"):
		queue_free()
