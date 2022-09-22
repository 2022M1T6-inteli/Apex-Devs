extends Popup
onready var pausado = false
var dimensoes = GlobalOptions.dimensoes
var textos = {"vision": "Nessa dimensão, a equipe deve descobrir qual problema vão abordar e quem são os clientes impactados pelo problema. Nesse momento o objetivo é saber o que é necessário para extinguir, ou ao menos reduzir o problema, quem utilizará essa invenção e o porquê é importante essa invenção/acabar com o problema. O importante é que a equipe deve pesquisar muito, pois tudo deve se basear em dados.",
"roadmap": "Roadmap é a dimensão de organização, nessa “fase” a equipe deve traçar um roteiro/guia, que servirá para ajudar na orientação e na organização do “projeto”. Esse guia deve ser extremamente detalhado, uma vez que ele é a base para organização do produto. As etapas do planejamento são específicas e devem estar presentes no guia, no Roadmap é definida as etapas de antes, durante e para depois da criação do produto.",
"stakeholders": "Essa dimensão corresponde a etapa de mensurar o nível de interesse de pessoas, grupos ou empresas no produto. A equipe deve aprender/estudar o que pode-se melhorar, a partir dos feedbacks dos interessados no produto, dessa forma mudar estratégias e abordagens é parte dessa dimensão. Além de tudo, nessa dimensão é necessário validar a eficácia da “criação”."}
var text = {"vision": "In this dimension, the team needs to discover which problem they are going to approach and which clients are impacted by it. Now the objective is knowing what is necessary to extinguish, or at least minimize the problem, who will use this invention and why it is important. The focus is that the team needs to research plenty of data to base on it.",
"roadmap": "Roadmap is the organization dimension. In this step the team needs to map a script/guide that will help in the orientation and organization of the “project”. This guide has to be extremely detailed, once it is the base for the product’s organization. The planning steps are specific and must be present on the guide. All steps must be present in the Roadmap (before, during and after the creation of the product).",
"stakeholders": "This dimension corresponds to the step of measuring people’s, group’s or company’s interest level on the product. The team must learn/study what can be improved from client’s feedback, thus changing strategies and approaches are part of this dimension. Besides that, in this dimension is necessary to validate the “creation’s” efficiency."}

func pausar():
	$".".show()
	get_tree().paused = true
	pausado = true
	dimensoes = GlobalOptions.dimensoes
	$AnimationPlayer.play("idle")
	get_parent().get_node("Hint").hide()
	
func despausar():
	$".".hide()
	$"Settings".hide()
	get_tree().paused = false
	pausado = false
	$support.text = ""
	get_parent().get_node("Hint").show()

# Menu de pausa
func _process(delta):
	if Input.is_action_just_pressed("ui_esc"):
		if pausado == true:
			despausar()
		else:
			pausar()

func _ready():
	for dimensao in dimensoes:
		if !dimensoes[dimensao]:
			get_node("Panel/"+dimensao).hide()
	
	if !GlobalOptions.isPortuguese:
		$Label.text = "Paused"
		$ButtonMenu.text = "Main Menu"
		$ButtonContinuar.text = "Continue"
		$ButtonOptions.text = "Settings"

func _on_ButtonContinuar_pressed():
	despausar()


func _on_ButtonMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Cenas/Menus/MenuPrincipal.tscn")


func _on_vision_pressed():
	if GlobalOptions.isPortuguese:
		$support.text = textos["vision"]
	else:
		$support.text = text["vision"]


func _on_roadmap_pressed():
	if GlobalOptions.isPortuguese:
		$support.text = textos["roadmap"]
	else:
		$support.text = text["roadmap"]


func _on_ButtonOptions_pressed():
	$Settings.show()


func _on_Back_pressed():
	GlobalOptions.masterVolume = $Settings/Container/RangeMaster.value
	GlobalOptions.musicVolume = $Settings/Container/RangeMusic.value
	GlobalOptions.sfxVolume = $Settings/Container/RangeSFX.value
	$Settings.hide()
