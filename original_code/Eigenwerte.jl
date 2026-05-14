using LinearAlgebra
using LinearMaps

# Definiere die stochastische Matrix P
P = [
    0.671600370027752 0.318223866790009 0.010175763182239
    0.211141060197664 0.643306379155436 0.1455525606469
    0.022680412371134 0.241237113402062 0.736082474226804
]

# Eigenwerte und Eigenvektoren der transponierten Matrix berechnen
eigvals, eigvecs = eigen(P')

# Den Eigenvektor finden, der dem Eigenwert 1 entspricht
stationary = eigvecs[:, 3]

# Normalisieren der stationären Verteilung
stationary = stationary / sum(stationary)

# Ausgabe der stationären Verteilung
println("Stationäre Verteilung: ", stationary)

30 * stationary # mal 30 da wir von jedem Zusatnd 10 als anfangsbedingung haben, gibt absoluten wert an

