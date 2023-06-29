extends Node


var world=null


func instance_node(node,location,parent,rotation):
	var node_instance=node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position=location
	node_instance.global_rotation=rotation
	return node_instance
