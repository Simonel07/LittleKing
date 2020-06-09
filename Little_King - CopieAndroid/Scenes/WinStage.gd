extends Area2D

export(String, FILE, "*tscn") var target_stage 
export(int) var Count

func _ready():
	pass

func _on_ChangeStage_body_entered(body):
	if "Player" in body.name:
		if Count >= 1:
			$CanvasLayer/Control2.show()
		elif Count <= 0:
			$CanvasLayer/Control2.hide()
			$CanvasLayer/Control.show()
			$AnimationPlayer.play("fade_in")
			$ChangeStage.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(target_stage)


func _on_Enemy_number(nr):
	Count = Count - nr


func _on_ChangeStage_body_exited(body):
	$CanvasLayer/Control2.hide()


func _on_Snake_numbers(nrs):
	Count = Count - nrs
