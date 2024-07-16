# Glioblastoma Simmulation mithilfe SSA

## Beschreibung
Diese Simulation modelliert die Dynamik von Tumorzellen unter verschiedenen Übergangsraten zwischen drei Zuständen: EP (Proliferierende Zellen), MP (Metastabile Zellen), und Diff (Differenzierte Zellen). Die Simulation verwendet den Stochastischen Simulationsalgorithmus (SSA) zur Berechnung der Zeitentwicklung des Systems.

Simmulation Julia ist der dafür gedachte Julia Code und notebook_SSA der entsprechende Pluto Code mit interaktiver Anpassung der Variablen und der entsprechenden Simmulationszeit.

## Installation

1. Klone das Repository:
    ```bash
    git clone https://github.com/felixklein84/Modellierung.git
    cd /Users/user/projects/Modellierung
    ```

2. Installiere erforderliche Pakete:
    ```bash
    using Pkg
    Pkg.instantiate()
    ```
