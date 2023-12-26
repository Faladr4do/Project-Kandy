extends Node

@onready var caixa_de_texto = preload("res://Project Kandy/Assets/CaixaTexto/caixa_texto.tscn")

var linhas_dialogo = []
var index_linha_atual = 0

var caixa_texto
var posicao_texto_caixa
var random

var dialogo_ativo = false
var avancar_linha = false

func comecar_dialogo(posicao, linhas: Array[String]):
	if dialogo_ativo:
		return
	
	linhas_dialogo = linhas
	posicao_texto_caixa = posicao
	_mostrar_caixa_texto()
	dialogo_ativo = true

# Função Protótipo Para Falas Random ao Interagir
#func pequeno_dialogo(posicao, linhas: Array[String], min_linhas, max_linhas):
	#if dialogo_ativo:
		#return
	#random = randi_range(min_linhas, max_linhas)
	#linhas[random]
	#linhas_dialogo = linhas
	#posicao_texto_caixa = posicao
	#_mostrar_caixa_texto()
	#dialogo_ativo = true

func _mostrar_caixa_texto():
	caixa_texto = caixa_de_texto.instantiate()
	caixa_texto.acabou_de_mostrar.connect(_texto_acabou_mostrar)
	get_tree().root.add_child(caixa_texto)
	caixa_texto.global_position = posicao_texto_caixa
	caixa_texto.mostrar_texto(linhas_dialogo[index_linha_atual])
	avancar_linha = false

func _texto_acabou_mostrar():
	avancar_linha = true
	
func _unhandled_input(event):
	if event.is_action_pressed("avancar dialogo") and dialogo_ativo and avancar_linha:
		caixa_texto.queue_free()
		index_linha_atual += 1
		if index_linha_atual >= linhas_dialogo.size():
			dialogo_ativo = false
			index_linha_atual = 0
			return
		_mostrar_caixa_texto()
	
