extends Node2D


var dialog = false

func _ready():
	$Player/Camera2D/CanvasLayer/DimensionFrame/Label.text = "Roadmap"
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Avance para a próxima fase")
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Go to the next level")

func _process(delta):
	if dialog:
		$Area2D.monitoring = false
		$Area2D.monitorable = false
		$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	dialog = true
	$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem':'dellson',
				'falas':[
					'E então, curtiu a renderização?',
					'Espero que esse problema que surgiu tenha ensinado-lhe a importância de se pensar e visualizar o que é necessário para solucionar um problema que você é responsável por resolver.',
					'Pensar e refletir sobre o problema são tarefas cruciais antes de pensar na solução.',
					'Além disso, espero que você tenha percebido que os detalhes são essenciais em qualquer solução.',
					'Isso que acabei de resumir para você, no modelo de produto é chamado de “visão”.',
					'Ailás, depois dê uma olhada no menu de pausa. Aprenda e se prepare para o próximo desafio!'
				]
			}
		])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem':'dellson',
				'falas':[
					'So, did you like the level?',
					"I hope this problem has teached you the importance of thinking and visualizing what's necessary for solving a problem given to you.",
					"Analysing and reflecting about it are crucial parts before thinking about a way of solving the task.",
					"And I hope you understood that details are essencial in any solution.",
					'What I just told you is the summary of what we call "vision" in the product model.',
					'Oh, before the next level, open the pause menu. Study and prepare for a new challenge!'
				]
			}
		])




func _on_Area2D2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Fase 2/Fase2.tscn")



func _on_Area2D_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Player/Camera2D/CanvasLayer/WeaponFrame.show()
