# gamedev-godot-dotnet

##  Projeto de Software:

1. **Qual é o tipo do seu projeto?**
     Um jogo digital, no qual se refere-se a qualquer tipo de jogo que é jogado em dispositivos eletrônicos, como computadores, consoles de videogame e              dispositivos móveis

##. Documentação para Usuários
- **Guia de Uso**
  Os usuários estão autorizados(a/e) e encorajados(a) a modificar o jogo atrávez de mods, remasters ou remakes
  Os usuários estão autorizados(a/e) a redistruibuir o jogo com os devidos créditos aos criadores originais
  Os usuários estão autorizados(a/e) a fazer remasters e remakes com os devidos créditos aos criadores originais
  Os usuários não estão autorizados(a/e) a redistribuir o jogo de forma paga e/ou sem os devidos créditos aos criadores
  
- **FAQ**
(ainda não temos perguntas frequentes)
  
- **Troubleshooting**
(https://docs.godotengine.org/en/stable/tutorials/troubleshooting.html)
  

## Tecnologias Utilizadas
- GDScript
- Godot


#Documentação - V de Vilão
 Elementos de Gameplay:

    Stealth: Evitar detecção usando cobertura e distrações.

    Quick Time Events (QTEs): Para ações críticas durante fugas e confrontos.

    Exploração: Cenários detalhados com objetos interativos para world-building.

    Diálogos: Sistema de escolhas que influenciam a narrativa, mas não alteram o destino final (jogo linear).

Progressão e Save System:

    Checkpoints: Após sequências importantes, como cenas de fuga ou diálogos.

    Save Points: Locais específicos (ex: casa do protagonista) onde o jogador pode salvar o progresso.

Atmosfera e Imersão:

    Trilha Sonora: Música adaptativa que muda conforme a tensão da cena. (WIP)

    Efeitos Sonoros: Sons ambientais realistas (chuva, sirenes, diálogos de fundo).

    Iluminação: Uso de luz e sombra para destacar emocões e perigos.



Características Principais

    Motor: Godot Engine 4.5

    Linguagem: GDScript

    Tipo: 2D/2.5D

    Plataformas: Windows, Linux, MacOSX 
    
Requisitos Mínimos

    Godot Engine: Versão <= 4.5

    RAM: 2GB mínimo

    Windows: x86_32 CPU with SSE2 support, x86_64 CPU with SSE4.2 support, ARMv8 CPU

        Example: Intel Core 2 Duo E8200, AMD FX-4100, Snapdragon X Elite

    macOS: x86_64 or ARM CPU (Apple Silicon)

        Example: Intel Core 2 Duo SU9400, Apple M1

    Linux: x86_32 CPU with SSE2 support, x86_64 CPU with SSE4.2 support, ARMv7 or ARMv8 CPU

        Example: Intel Core 2 Duo E8200, AMD FX-4100, Raspberry Pi 4 
        
        Android: SoC with any 32-bit or 64-bit ARM or x86 CPU

    Example: Qualcomm Snapdragon 430, Samsung Exynos 5 Octa 5430


        Native editor: Windows 11/10, macOS 10.13 (Compatibility) or macOS 10.15 (Forward+/Mobile), Linux distribution released after 2018
        Web editor: Recent versions of mainstream browsers: Firefox and derivatives (including ESR), Chrome and Chromium derivatives, Safari and WebKit                 derivatives.

    Espaço em disco: 200 MB (used for the executable, project files and cache). Exporting projects requires downloading export templates separately (1.3 GB         after installation).


###############################################################################################################

Exemplo de como usar GDScript para futuros mantenedores do código: (fonte do site oficial do GDScript)

- # Everything after "#" is a comment.
# A file is a class!

# (optional) icon to show in the editor dialogs:
@icon("res://path/to/optional/icon.svg")

# (optional) class definition:
class_name MyClass

# Inheritance:
extends BaseClass


# Member variables.
var a = 5
var s = "Hello"
var arr = [1, 2, 3]
var dict = {"key": "value", 2: 3}
var other_dict = {key = "value", other_key = 2}
var typed_var: int
var inferred_type := "String"

# Constants.
const ANSWER = 42
const THE_NAME = "Charly"

# Enums.
enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
enum Named {THING_1, THING_2, ANOTHER_THING = -1}

# Built-in vector types.
var v2 = Vector2(1, 2)
var v3 = Vector3(1, 2, 3)


# Functions.
func some_function(param1, param2, param3):
	const local_const = 5

	if param1 < local_const:
		print(param1)
	elif param2 > 5:
		print(param2)
	else:
		print("Fail!")

	for i in range(20):
		print(i)

	while param2 != 0:
		param2 -= 1

	match param3:
		3:
			print("param3 is 3!")
		_:
			print("param3 is not 3!")

	var local_var = param1 + 3
	return local_var


# Functions override functions with the same name on the base/super class.
# If you still want to call them, use "super":
func something(p1, p2):
	super(p1, p2)


# It's also possible to call another function in the super class:
func other_something(p1, p2):
	super.something(p1, p2)


# Inner class
class Something:
	var a = 10


# Constructor
func _init():
	print("Constructed!")
	var lv = Something.new()
	print(lv.a)

###############################################################################################################

#### B. Documentação de Desenvolvimento
- **Guia de Contribuição**
  https://github.com/bernardosgarcia
  https://github.com/leozoka0506
  https://github.com/Marchador1
  https://github.com/MathiasTito


   
 **Qual é o objetivo principal?**
    Realizar as entregas da matéria de Gamedeveloping
   
 **Quem é o público da documentação?**
   qualquer pessoa que de um jeito ou de outro conseguiu acesso ao software a à direção de arte e queira modifica-la (favor revisar o guia de uso, ele é bem simples)
