# Star Evolution
Proyecto atomico que se basa en crear una maquina de estados que bajo ciertas condiciones de objeto transcicione el estado; cambiando así de unaestrella a otra

___

# Clasificación de estrellas en una FSM
Este código clasifica las estrellas según su masa y su etapa de vida a través de una Máquina de Estados Finitos (FSM, por sus siglas en inglés). El código está diseñado para ser utilizado en un proyecto de Godot.

## Definición de las constantes
Las siguientes constantes se definen para representar cada tipo de estrella y las etapas por las que pasa durante su vida:

```gdscript
const O = 0
const B = 1
const A = 2
const F = 3
const G = 4
const K = 5
const M = 6

const stages = {
    O: ["Main Sequence", "Red Supergiant"],
    B: ["Main Sequence", "Red Giant", "Red Supergiant"],
    A: ["Main Sequence", "Red Giant"],
    F: ["Main Sequence", "Subgiant", "Red Giant"],
    G: ["Main Sequence", "Subgiant", "Red Giant", "Horizontal Branch"],
    K: ["Main Sequence", "Subgiant", "Red Giant", "Horizontal Branch", "Asymptotic Giant Branch"],
    M: ["Main Sequence", "Subgiant", "Red Giant", "Horizontal Branch", "Asymptotic Giant Branch"]
}
```

Las constantes O a M se utilizan para identificar cada tipo de estrella según su masa. Las etapas de la vida de una estrella se definen como una lista de cadenas, donde cada cadena es una etapa. Se utiliza un diccionario para asociar cada tipo de estrella con sus etapas de vida correspondientes.

## Definición de las transiciones
Las transiciones se definen en la lista transitions. Cada transición se representa como un diccionario con tres claves:

`from`: la etapa actual de la estrella.
`to`: la siguiente etapa de la estrella.
`condition`: una función que toma la masa de la estrella como argumento y devuelve true o false según si se cumple o no la condición para la transición.

```gdscript
const transitions = [
    {"from": O, "to": B, "condition": func(x): return x > 20},
    {"from": B, "to": A, "condition": func(x): return x > 8 and x <= 20},
    {"from": A, "to": F, "condition": func(x): return x > 1.5 and x <= 8},
    {"from": F, "to": G, "condition": func(x): return x > 1.2 and x <= 1.5},
    {"from": G, "to": K, "condition": func(x): return x > 0.8 and x <= 1.2},
    {"from": K, "to": M, "condition": func(x): return x > 0.5 and x <= 0.8}
]
```

Cada transición se evalúa en orden, y se devuelve la primera transición que cumpla su condición.

# Función para obtener la siguiente etapa
La siguiente función utiliza la lista de transiciones para obtener la siguiente etapa de una estrella dada su masa y su etapa actual:

```gdscript
func get_next_stage(mass: float, current_stage: String) -> String:
    # Obtener la clave del diccionario que corresponde al tipo de estrella actual
    current_type = None
    for key, value in stages.items():
        if current_stage in value:
            current_type = key
            break

    # Evaluar cada transición y devolver la siguiente etapa si se cumple la condición
    for transition in transitions:
        if transition["from"] == current_type and transition["condition"](mass):
            return transition["to"]

    # Si no se cumple ninguna transición, la estrella permanece en su etapa actual
    return current_stage
```

La función primero determina el tipo de estrella actual buscando en el diccionario stages la clave que corresponde a la lista de etapas de vida que contiene la etapa actual. A continuación, evalúa cada transición en orden, buscando la primera que cumpla su condición y devuelve la siguiente etapa si se cumple.

Si ninguna transición se cumple, lo que significa que la estrella ha alcanzado el final de su vida útil, la función devuelve la etapa actual de la estrella.

#### Ejemplos de uso
A continuación se muestra un ejemplo de cómo se puede utilizar la función get_next_stage para clasificar una estrella dada su masa y su etapa actual:

```gdscript
# Definir la masa y la etapa actual de la estrella
mass = 1.2
current_stage = "Main Sequence"

# Obtener la siguiente etapa de la estrella
next_stage = get_next_stage(mass, current_stage)

# Imprimir la clasificación de la estrella
print("Esta estrella es de tipo", next_stage, "con una masa de", mass)

```

Este código imprimirá la siguiente salida:
```
Esta estrella es de tipo G con una masa de 1.2

```
Esto indica que la estrella es de tipo G (es decir, una estrella amarilla como nuestro Sol) y se encuentra en su etapa de la secuencia principal.