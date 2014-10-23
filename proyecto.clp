(defclass Fobia
	(is-a USER)
	(role concrete)
;	(comment Clase base fobia)
	(multislot Caracteristicas
		(type INSTANCE)
;		(comment "Instancia en la que se insertaran la clase caracteristica")
	)
)

(defclass Caracteristica
	(is-a USER)
	(role concrete)
	(single-slot Cadena
		(type STRING)
; 	)	(comment "Este es el string en donde se guarda la caracteristica")
)

