extends Control


func _on_new_pressed():
	get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")



func _on_quit_pressed():
	get_tree().quit()


func _on_debug_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/test_level.tscn")
