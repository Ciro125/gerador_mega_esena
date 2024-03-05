import random

def gerar_numeros_aleatorios(qtd_numeros, intervalo, numeros_fixos):
    numeros_gerados = set(numeros_fixos)
    numeros_restantes = qtd_numeros - len(numeros_fixos)
    
    if numeros_restantes < 0:
        raise ValueError("O número de números fixos é maior do que o número total de números a serem gerados.")
    
    while len(numeros_gerados) < qtd_numeros:
        numero_aleatorio = random.randint(intervalo[0], intervalo[1])
        numeros_gerados.add(numero_aleatorio)
    
    return sorted(list(numeros_gerados))

# Exemplo de uso:
qtd_numeros = int(input("Quantos números aleatórios você quer gerar? "))
intervalo = tuple(map(int, input("Qual é o intervalo dos números (separados por espaço)? ").split()))
numeros_fixos = list(map(int, input("Quais são os números que você quer que sempre apareçam (separados por espaço)? ").split()))

try:
    numeros_aleatorios = gerar_numeros_aleatorios(qtd_numeros, intervalo, numeros_fixos)
    print("Números aleatórios gerados:", numeros_aleatorios)
except ValueError as e:
    print("Erro:", e)
