extends Resource
class_name GameData

# variaveis do jogo principal
@export var money: int = 0
@export var velo_estudo: float = 0.2
@export var velocidade_custo: int = 5
@export var qtd_livros: int = 1 
@export var livros_custo: int = 10
@export var ganhos_EXP: int = 1
@export var EXP_custo: int = 20
@export var Assistente_custo: int = 50
@export var Assistente_AFK_gains: int = 0

# ganhos offline:
@export var ultimo_login: float = 0.0 

# prestigio:
@export var nivel_de_prestigio: int = 0
@export var moedas_prestigio: int = 0
@export var money_for_prestigio: int = 1000000
@export var p1: bool = false
@export var p2: bool = false
@export var p3: bool = false
@export var p4: bool = false
@export var p5: bool = false
@export var p6: bool = false

# audio e sfx:
@export var musica: bool = true
@export var sfx: bool = true

# Background
@export var bg: String = "PapelBg"
