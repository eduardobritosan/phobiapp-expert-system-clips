(defclass Fobia
	(is-a USER)
	(role concrete)
	(single-slot nombre
		(type STRING)
		(default "No tiene fobias")
		(create-accessor read-write))
	(multislot atributos
		(type STRING)
		(create-accessor read-write)))
(definstances fobias
	([Instancia1] of Fobia
		(atributos ["Miedo a las alturas","Asociado al vertigo","Ansiedad en ascensores abiertos"])
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
		(atributos ["Miedo a conducir","Ansiedad al conducir","Suele venir de un accidente en coche"])
		(nombre "Emetofobia"))
	([nuevaFobia] of Fobia
		(atributos []))
)
(deffunction ask (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read)))
   ?answer
)
(deffunction y-n (?question)
   (bind ?response (ask ?question si no s n))
   (if (or (eq ?response si) (eq ?response s))
       then TRUE 
       else FALSE)
)
(deffunction printall (?v) "imprime todos los elementos de un multislot"
  (if (> (length$ ?v) 0) then
   (loop-for-count (?i 1 (length ?v))
     (send (nth$ ?i ?v) print)
	 (printout t crlf)))
)
;(deffunction compare ($?attr)
;	(find-instance (eq $?attr atributos))
;)

(defrule presentacion "regla que presenta al sistema"
 (declare (salience 10))
  =>
  (printout t "-----------------------------------------------" crlf)
  (printout t "------ Sistema de Recomendación de juegos -----" crlf)
  (printout t "-----------------------------------------------" crlf)
  (printout t crlf)
 )
(defrule preguntas
=>
	(if (y-n "Tiene miedo a las alturas? (s/n)") then
		(bind ?newattr "Miedo a las alturas")
		(printout ?newattr)
		(slot-insert$ nuevaFobia atributos (length atributos) ?newattr)
		(if (y-n "Sufre de vertigo? (s/n)") then
			(bind ?newattr "Asociado al vertigo")
			(slot-insert$ nuevaFobia atributos (length atributos) ?newattr)
		)
		(if (y-n "Siente ansiedad en ascensores abiertos? (s/n)") then
			(bind ?newattr "Ansiedad en ascensores abiertos")
			(slot-insert$ nuevaFobia atributos (length atributos) ?newattr)
		)
	)
)


