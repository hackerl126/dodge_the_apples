extends RigidBody2D

func _ready():
	randomize()

func _process(delta):
	$Sprite.rotation_degrees+=randi_range(5,15)


func _on_visibility_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("bullets"):
		queue_free()
