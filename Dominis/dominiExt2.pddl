(define (domain ReservesHotel)

  (:requirements :strips :typing :adl :equality :fluents )

  (:types habitacio reserva dia - object)

  (:functions
    (valor-dia ?d - dia)
    (habitacio-capacitat   ?h - habitacio)
    (habitacio-orientacion ?h - habitacio)

    (reserva-orientacion ?r - reserva)
    (reserva-capacitat ?r - reserva)
    (reserva-diaInici  ?r - reserva)
    (reserva-diaFi     ?r - reserva)

    (reserves-ateses)

  )

  (:predicates
    (atessa ?x - reserva)
    (ocupada ?x - habitacio ?y - dia)
  )



  (:action assignarSenseOrientacio
    :parameters (?r - reserva ?hab - habitacio)
    :precondition (and (not (atessa ?r)) (>= (habitacio-capacitat ?hab) (reserva-capacitat ?r))
                       (not (= (habitacio-orientacion ?hab) (reserva-orientacion ?r)) )
                       (forall (?d - dia) (or (not (and (<= (reserva-diaInici ?r) (valor-dia ?d)) (>= (reserva-diaFi ?r) (valor-dia ?d)) ) )
                                              (not (ocupada ?hab ?d))
                                          )
                       )
                  )
    :effect (and (atessa ?r) (decrease (reserves-ateses) 3)
                 (forall (?d - dia) (when (and (<= (reserva-diaInici ?r) (valor-dia ?d))   ; diaInici >= ?d
                                               (>= (reserva-diaFi ?r) (valor-dia ?d))
                                          ) (ocupada ?hab ?d) )
                 )
            )
  )

  (:action assignarAmbOrientacio
    :parameters (?r - reserva ?hab - habitacio)
    :precondition (and (not (atessa ?r)) (>= (habitacio-capacitat ?hab) (reserva-capacitat ?r))
                       (= (habitacio-orientacion ?hab) (reserva-orientacion ?r))
                       (forall (?d - dia) (or (not (and (<= (reserva-diaInici ?r) (valor-dia ?d)) (>= (reserva-diaFi    ?r) (valor-dia ?d)) ) )
                                              (not (ocupada ?hab ?d))
                                          )
                       )
                  )
    :effect (and (atessa ?r) (decrease (reserves-ateses) 5)
                 (forall (?d - dia) (when (and (<= (reserva-diaInici ?r) (valor-dia ?d))   ; diaInici >= ?d
                                               (>= (reserva-diaFi ?r) (valor-dia ?d))
                                          ) (ocupada ?hab ?d) )
                 )
            )
  )


  (:action ignorar
    :parameters (?r - reserva)
    :precondition (not(atessa ?r))
    :effect (and (atessa ?r) (decrease (reserves-ateses) 1) )
  )
)
