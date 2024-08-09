using LinearAlgebra

P=[
    0 1/2 1/2
    1/3 0 2/3
    1 0 0
    ]

Q =[
    -6 3 3 
    1 -3 2
    2 0 -2
]

eigenwerte, eigenvektoren = eigen(P')

dist = eigenvektoren[:,3]
norm_dist = dist / sum(dist)


# Q variante 

# Transponiere Q, da wir den Nullraum der Zeilenvektoren benötigen
Q_T = transpose(Q)

# Finde den Nullraum von Q'
null_space = nullspace(Q_T)

# Da der Nullraum normalerweise ein eindimensionaler Raum ist, 
# nehmen wir den ersten (und einzigen) Vektor aus dem Nullraum
s = null_space[:, 1]

# Normiere den Vektor so, dass die Summe seiner Elemente gleich 1 ist
normed_s = s / sum(s)

