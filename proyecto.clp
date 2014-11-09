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
(definstances initial
	([Instancia1] of Fobia
		(atributos "Miedo a las alturas" "Asociado al vertigo" "Ansiedad en ascensores abiertos")
		(nombre "Acrofobia"))
	([Instancia2] of Fobia
		(atributos "Miedo a vomitar" "Evitan a beber alcohol" "Ansiedad viendo vomito o alguien vomitar")
		(nombre "Emetofobia"))
	([Instancia3] of Fobia
		(atributos "Miedo a espacios cerrados" "Elige situarse cerca de las salidas" "Suele coger escaleras")
		(nombre "Claustrofobia"))
	([Instancia4] of Fobia
		(atributos "Miedo a lugares donde no pueda huir" "Temor a estar solo" "No suele salir de casa")
		(nombre "Agorafobia"))
	([Instancia5] of Fobia
		(atributos "Miedo a conducir" "Ansiedad al conducir" "Suele venir de un accidente en coche")
		(nombre "Amaxofobia"))
	([resultado] of Fobia
		(nombre "Test"))
)
(defglobal ?*chg* = FALSE)
(deffunction ask (?question $?allowed-values) ""
   (printout t ?question)
   (bind ?answer (read))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read)))
   ?answer
)
(deffunction y-n (?question) ""
   (bind ?response (ask ?question si no s n))
   (if (or (eq ?response si) (eq ?response s))
       then TRUE 
       else FALSE)
)
(deffunction compara-todo (?p) ""
	(if (>= 0 (length (send [resultado] get-atributos))) then
		(return FALSE)
	)
	(if (eq (send ?p get-nombre) (send [resultado] get-nombre)) then
		(return FALSE)
	)
	(if (eq (send ?p get-atributos) (send [resultado] get-atributos)) then
		(printout t crlf crlf (send ?p get-nombre) " es el diagnostico mas probable." crlf crlf)
		(bind ?*chg* TRUE)
		(return TRUE)
	)	
)
(defmessage-handler Fobia print primary ()
	(send ?self print))
(defrule compare
?ins <- (object (is-a Fobia))
=>
	(compara-todo ?ins)
)
(defrule presentacion "regla que presenta al sistema"
	(declare (salience 10))
	=>
	(printout t "--------------~~~~~~~~~~~~~~~~~~~~---------------------------~~~~~~~~~~~~~~~~~~~~--------------------------~~~~~~~~~~~~~~~~~~~~-------------" crlf crlf)
	(printout t "~~~~~~~~~~~~~~PHOBIA EXPERT SYSTEM~~~~~~~~~~~~~~~~~~~~~~~~~~~PHOBIA EXPERT SYSTEM~~~~~~~~~~~~~~~~~~~~~~~~~~PHOBIA EXPERT SYSTEM~~~~~~~~~~~~~" crlf crlf)
	(printout t "--------------~~~~~~~~~~~~~~~~~~~~---------------------------~~~~~~~~~~~~~~~~~~~~--------------------------~~~~~~~~~~~~~~~~~~~~-------------" crlf crlf)
	(printout t "Bienvenido! Este sistema buscara si usted padece alguna de las fobias mas comunes a traves de un preguntas simples de si o no, esperamos que disfrute!"crlf crlf "EMPECEMOS!!!"crlf crlf)
)
(defrule preguntas ""
=>
	(if (y-n "Tiene miedo a las alturas? (s/n)") then
		(bind ?newattr "Miedo a las alturas")
		(slot-insert$ resultado atributos (length atributos) ?newattr)
		(if (y-n "Sufre de vertigo? (s/n)") then
			(bind ?newattr "Asociado al vertigo")
			(slot-insert$ resultado atributos (length atributos) ?newattr)
		)
		(if (y-n "Siente ansiedad en ascensores abiertos? (s/n)") then
			(bind ?newattr "Ansiedad en ascensores abiertos")
			(slot-insert$ resultado atributos (length atributos) ?newattr)
		)
	else 
		(if (y-n "Tiene un miedo irracional al acto de vomitar, sea propio o hecho por terceros? (s/n)") then
			(bind ?newattr "Miedo a vomitar")
			(slot-insert$ resultado atributos (length atributos) ?newattr)
			(if (y-n "Evita a beber alcohol a toda costa, solo para evitar vomitar? (s/n)") then
				(bind ?newattr "Evitan a beber alcohol")
				(slot-insert$ resultado atributos (length atributos) ?newattr)
			)
			(if (y-n "Siente ansiedad viendo vomito o alguien vomitar? (s/n)") then
				(bind ?newattr "Ansiedad viendo vomito o alguien vomitar")
				(slot-insert$ resultado atributos (length atributos) ?newattr)
			)
		else 
			(if (y-n "Tiene miedo a los espacios cerrados? (s/n)") then
				(bind ?newattr "Miedo a espacios cerrados")
				(slot-insert$ resultado atributos (length atributos) ?newattr)
				(if (y-n "Elige situarse cerca de las salidas en cualquier evento o situacion? (s/n)") then
					(bind ?newattr "Elige situarse cerca de las salidas" )
					(slot-insert$ resultado atributos (length atributos) ?newattr)
				)
				(if (y-n "Suele coger escaleras en vez de ascensores? (s/n)") then
					(bind ?newattr "Suele coger escaleras")
					(slot-insert$ resultado atributos (length atributos) ?newattr)
				)
			else 
				(if (y-n "Teme irracionalmente a lugares de los no pueda irse rapidamente por su amplitud? (s/n)") then
					(bind ?newattr "Miedo a lugares donde no pueda huir")
					(slot-insert$ resultado atributos (length atributos) ?newattr)
					(if (y-n "Siente miedo a estar solo? (s/n)") then
						(bind ?newattr "Temor a estar solo" )
						(slot-insert$ resultado atributos (length atributos) ?newattr)
					)
					(if (y-n "Suele evitar salir de casa todo lo posible? (s/n)") then
						(bind ?newattr "No suele salir de casa")
						(slot-insert$ resultado atributos (length atributos) ?newattr)
					)
					else
						(if (y-n "Siente miedo irracional a conducir? (s/n)") then
							(bind ?newattr "Miedo a conducir")
							(slot-insert$ resultado atributos (length atributos) ?newattr)
							(if (y-n "Siente ataques de ansiedad al conducir? (s/n)") then
								(bind ?newattr "Ansiedad al conducir" )
								(slot-insert$ resultado atributos (length atributos) ?newattr)
							)
							(if (y-n "Tuvo un accidente de coche en el pasado? (s/n)") then
								(bind ?newattr "Suele venir de un accidente en coche")
								(slot-insert$ resultado atributos (length atributos) ?newattr)
							)	
						)
				)
			)
		)
	)
)

(defrule final
(declare (salience -1))
=>
	(if(eq ?*chg* FALSE)then
	(printout t crlf crlf "No sufre usted de fobias" crlf crlf)
	)
)
