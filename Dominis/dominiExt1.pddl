  (define (domain ReservesHotel)

	(:requirements :strips :typing :adl :equality :fluents )

	 (:types habitacio reserva dia - object)

  (:functions
    (valor-dia ?d - dia)
    (habitacio-capacitat ?h - habitacio)
    (reserva-capacitat ?r - reserva)
    (reserva-diaInici  ?r - reserva)
    (reserva-diaFi     ?r - reserva)
    (reserves-ateses)	;heuristic

  )

  (:predicates
    (atessa ?x - reserva)
    (ocupada ?x - habitacio ?y - dia)
  )

  (:action assignar
    :parameters (?r - reserva ?hab - habitacio)
    :precondition (and  (not(atessa ?r))
                        (>= (habitacio-capacitat ?hab) (reserva-capacitat ?r))
                        (forall (?d - dia)
                                (or (not(and (<= (reserva-diaInici ?r) (valor-dia ?d))
                                             (>= (reserva-diaFi    ?r) (valor-dia ?d))))
                                    (not(ocupada ?hab ?d)))))
    :effect (and  (atessa ?r)
                  (increase (reserves-ateses) 2)
                  (forall (?d - dia)
                          (when (and (<= (reserva-diaInici ?r) (valor-dia ?d))   ; diaInici >= ?d
                                     (>= (reserva-diaFi    ?r) (valor-dia ?d)))  ; diaFi    <= ?d
                                (ocupada ?hab ?d))))

  )

  (:action ignorar
    :parameters (?r - reserva)
    :precondition (not(atessa ?r))
    :effect (and (atessa ?r) (increase (reserves-ateses) 1))
  )
)
