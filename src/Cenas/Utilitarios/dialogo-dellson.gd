extends PopupDialog

onready var dialogBoxLabel = $DialogBox/Label
var podeIrParaProximaLinha = false
var completarFrase = false
# Essa variável determina se é a primeira vez que o player vê determinada fala
var primeiraVez = 0

var dialogos = []
var dialogoAtual = {"personagem": "", "falas": []}

# Função que estabelece qual sprite usar quando estiver na fala
func getDialogSpriteFilePath():
	if dialogoAtual["personagem"] == 'dellson':
		return "res://Public/dellsonCaixaDialogo.png"
	elif dialogoAtual["personagem"] == 'jose':
		return "res://Public/Jose.png"
	
	return "res://Public/icon.png"
		
# Função que mostra a próxima mensagem do array de diálogos
func mostrarMensagem() -> void:
	if dialogoAtual["falas"].size() == 0 && dialogos.size() == 0:
		get_tree().paused = false
		hide()
		return
	
	if(dialogoAtual["falas"].size() == 0):
		dialogoAtual = dialogos.pop_front()
	
	var text = dialogoAtual["falas"].pop_front()	
	dialogBoxLabel.percent_visible = 0
	dialogBoxLabel.text = text
	podeIrParaProximaLinha = false

	# Verifica se a foto da caixa de diálogo está condizente com o personagem e troca caso necessário
	$DialogSprite.texture = load(getDialogSpriteFilePath())

	show()
	return
	
# Neste caso, esta função serve para que ao pressionar o botão E, a fala mude para a próxima
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if(podeIrParaProximaLinha):
			mostrarMensagem()
		else:
			completarFrase = true

func _on_Timer_timeout():
	if(dialogBoxLabel.percent_visible >= 1):
		podeIrParaProximaLinha = true
	else:
		if completarFrase:
			dialogBoxLabel.percent_visible = 1
			podeIrParaProximaLinha = true
			completarFrase = false
		else:
			var percentVisible = 0.01
			if(len(dialogBoxLabel.text) < 30):
				percentVisible = 0.03
			elif len(dialogBoxLabel.text) >= 30 && len(dialogBoxLabel.text) <= 60:
				percentVisible = 0.02
				
			dialogBoxLabel.percent_visible += percentVisible


# A partir daqui, cada função determina qual fala o jogo deve dar display ao atravessar certos pontos de interesse


func _on_TutoraiMapa1Fala1_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 0:
		dialogos = [
			{
				'personagem': 'jose',
				'falas': [
					'Uooou. Esse treinamento é REALMENTE imersivo.'
				]
			},
			{
				'personagem': 'dellson',
				'falas': [
					'Ei, você!',
					'Você mesmo com cara de bobão!',
					'Preciso falar com a Fabi para ter pelo menos um tutorial de como se mexer antes dos novatos chegarem aqui…',
					'Mas ainda bem que você tem…',
					'EEEU DELLSON! Seu capitão! Ou comandante!'
				]
			},
			{
				'personagem': 'fabiana',
				'falas': [
					'Instrutor, Dellson. Instrutor.'
				]
			},
			{
				'personagem': 'dellson',
				'falas': [
					'Pode ser, Fabi, pode ser…',
					'Vem cá, novato. EU serei seu mestre dos magos',
					'...',
					'Ah é, você se movimenta com WASD',
					'Venha até aqui para saber mais.'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1
	



func _on_TutoraiMapa1Fala2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 1:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas': [
					'Aff… Eu preciso falar com a Fabi sobre esse algoritmo de spawn.',
					'Então, novato, aqui você irá aprender sobre as dimensões do modelo de produto. Ao total são 9. N. O. V. E. Você sabe contar?'
				]
			},
			{
				'personagem': 'jose',
				'falas': [
					'Sim, Dellson. Você não precisa me explicar TUUUUDO'
				]
			},
			{
				'personagem': 'dellson',
				'falas': [
					'Ahã! Sabia que você é um cara inteligente.',
					'Bom, continuando… São 9 dimensões. Então, você terá 9 desafios para completar aqui. Para vencer cada um dos desafios,',
					'Você terá que utilizar um conceito da dimensão que ele representa. Ou seja, você só sai daqui se aprender!!!',
					'Legal, né? Eu que tive a ideia. Agora avance para a próxima área para continuarmos com o treinamento..'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_TutorialMapa2Fala1_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 0:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas': [
					'Eu fiquei com preguiça de terminar essa área, então fiz o upload de um mapa da Internet mesmo. Espero que você não fique assustado…',
					'hehe'
				]
			},
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez +=1


func _on_TuroailMapa2Fala2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 1:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas': [
					'BOO!!',
					'Errei o timing?',
					'… Enfim, quando você se deparar com um lugar o qual não consegue passar, pressione ESPAÇO para atravessar pequenos obstáculos.'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_Area2D2_area_entered(area):
	if primeiraVez == 0:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'Você estava esperando alguma coisa? Eu achei que já tinha te dado um susto.',
					'De qualquer forma, caso você encontre inimigos, presione P para atacá-los.',
					'Aqui está um boneco para você treinar!',
					'Quando conseguir derrotá-lo, posso considerar que você que você já aprendeu o básico e consegue se virar sem mim.',
					'Assim eu posso voltar para meu modo de hibernação.',
					'...',
					'Agora venha aqui e destrua esse boneco!'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_Hurtbox_area_entered(area):
	if primeiraVez == 1:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'ISSO, ACABA COM ELE!!',
					'Ahem... Quando você derrotá-lo, eu irei abrir esse portão a direita, ele te levará ao mundo externo'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez +=1
		

func _on_Area2D3_area_entered(area):
	if primeiraVez == 2:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'ESPERA!!!',
					'Eu sei que você já aprendeu o básico, mas com o meu intelecto e seu ... corpo(?), eu acho que chegaremos muito mais longe e você aprenderá muito mais.',
					'O que você acha, parceiro?'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_Area2D4_area_entered(area):
	if primeiraVez == 3:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'Não precisa responder, vou entrar na sua mochila!',
					'Com licença.'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1
