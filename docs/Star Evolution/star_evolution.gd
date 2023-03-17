# Clasificación de estrellas
const O = 0
const B = 1
const A = 2
const F = 3
const G = 4
const K = 5
const M = 6

# Definición de las etapas
const stages = {
    O: ["Main Sequence", "Red Supergiant"],
    B: ["Main Sequence", "Red Giant", "Red Supergiant"],
    A: ["Main Sequence", "Red Giant"],
    F: ["Main Sequence", "Subgiant", "Red Giant"],
    G: ["Main Sequence", "Subgiant", "Red Giant", "Horizontal Branch"],
    K: ["Main Sequence", "Subgiant", "Red Giant", "Horizontal Branch", "Asymptotic Giant Branch"],
    M: ["Main Sequence", "Subgiant", "Red Giant", "Horizontal Branch", "Asymptotic Giant Branch"]
}

# Definición de las transiciones
const transitions = [
    {"from": O, "to": B, "condition": func(x): return x > 20},
    {"from": B, "to": A, "condition": func(x): return x > 8 and x <= 20},
    {"from": A, "to": F, "condition": func(x): return x > 1.5 and x <= 8},
    {"from": F, "to": G, "condition": func(x): return x > 1.2 and x <= 1.5},
    {"from": G, "to": K, "condition": func(x): return x > 0.8 and x <= 1.2},
    {"from": K, "to": M, "condition": func(x): return x > 0.5 and x <= 0.8}
]

# Función que calcula la próxima etapa de la estrella
func get_next_stage(current_stage, mass):
    for transition in transitions:
        if transition["from"] == current_stage and transition["condition"](mass):
            return transition["to"]
    return current_stage

# Ejemplo de uso
var current_stage = O
var mass = 25.0

while current_stage != "Red Supergiant":
    print(stages[current_stage])
    current_stage = get_next_stage(current_stage, mass)
    mass -= 1.0

print(stages[current_stage])