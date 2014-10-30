(defclass Fobia
	(is-a USER)
	(role concrete)
	(single-slot nombre
		(type STRING)
		(create-accessor read-write))
	(multislot atributos
		(type STRING)
		(create-accessor read-write)))
(definstances fobias
	([Instancia1] of Fobia
		(atributos ["Miedo a las alturas","Asociado al vertigo","Tratable con medicamento"])
		(nombre "Acrofobia"))
	([Instancia2] of Fobia
		(atributos ["Miedo a vomitar","Evitan a beber alcohol"])
		(nombre "Emetofobia"))
	([Instancia3] of Fobia
		(atributos ["Miedo a espacios cerrados","Elige situarse cerca de las salidas","Suele coger escaleras"])
		(nombre "Claustrofobia"))
	([Instancia4] of Fobia
		(atributos ["Miedo a lugares donde no pueda huir","Temor a estar solo","No suele salir de casa"])
		(nombre "Agorafobia"))
	([Instancia5] of Fobia
		(atributos ["Suele suceder en conductores","Ansiedad al conducir","Suele venir de un accidente en coche"])
		(nombre "Emetofobia")))

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
   )
   ?answer)

(deffunction si-o-no-p (?question)
   (bind ?response (ask-question ?question si no s n))
   (if (or (eq ?response si) (eq ?response s))
       then TRUE 
       else FALSE))
