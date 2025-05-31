extends RigidBody2D

func _ready():
	$VisibilityNotifier2D.screen_exited.connect(_on_screen_exited)
	$Area2D.area_entered.connect(_on_area_2d_area_entered)
	randomize()

func _process(delta):
	$Sprite.rotation_degrees+=randi_range(5,15)

func _on_screen_exited():
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullets"):
		queue_free()
