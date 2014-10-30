(defclass Fobia
	(is-a USER)
	(role concrete)
	(multislot atributos
		(type INSTANCE)
		(create-accessor read-write))
)
(defclass Caracteristica
	(is-a USER)
	(role concrete)
	(single-slot Cadena
		(type STRING)
 		(comment "Este es el string en donde se guarda la caracteristica")
		(create-accesor read-write))
)