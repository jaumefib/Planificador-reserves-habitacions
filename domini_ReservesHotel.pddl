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
  (noAmbCapacitatsIguals ?x - reserva) ; no hi han habitacions amb igual capacitat
)



(:action assignarIgualCapacitat
  :parameters (?r - reserva ?hab - habitacio)
  :precondition (and  (not (atessa ?r))
                      (= (habitacio-capacitat ?hab) (reserva-capacitat ?r))
                      (forall (?d - dia)
                              (or (not (and (<= (reserva-diaInici ?r) (valor-dia ?d))
                                           (>= (reserva-diaFi    ?r) (valor-dia ?d))
                                       )
                                  ) (not (ocupada ?hab ?d))
                              )
                      )
                )
  :effect (and  (atessa ?r)
                (increase (reserves-ateses) 5)
                (forall (?d - dia)
                        (when (and (<= (reserva-diaInici ?r) (valor-dia ?d))   
                                   (>= (reserva-diaFi    ?r) (valor-dia ?d)))
                              (ocupada ?hab ?d)
                        )
                )
          )
)


(:action compararCapacitats
  :parameters (?r - reserva)
  :precondition (and (not (atessa ?r)) (not (noAmbCapacitatsIguals ?r))
                     (forall (?h - habitacio ?d - dia)
                             (and (<= (reserva-diaInici ?r) (valor-dia ?d))
                                  (>= (reserva-diaFi    ?r) (valor-dia ?d))
                                  (not (ocupada ?h ?d))
                                  (not (= (habitacio-capacitat ?h) (reserva-capacitat ?r)))
                             )
                     )
                )
  :effect (and (noAmbCapacitatsIguals ?r))
)


(:action assignarDifCapacitat
  :parameters (?r - reserva ?h - habitacio)
  :precondition (and (not (atessa ?r)) (noAmbCapacitatsIguals ?r) (> (habitacio-capacitat ?h) (reserva-capacitat ?r))
                     (forall (?d - dia)
                             (or (not (and (<= (reserva-diaInici ?r) (valor-dia ?d))
                                           (>= (reserva-diaFi    ?r) (valor-dia ?d))
                                      )
                                  ) (not (ocupada ?h ?d))
                             )
                     )
                     (forall (?rx - reserva)
                             (or (atessa ?rx)
                                 (not (and (< (reserva-capacitat ?r) (reserva-capacitat ?rx))
                                           (<= (reserva-capacitat ?rx) (habitacio-capacitat ?h))
                                      )
                                 )
                             )
                     )
                )
  :effect (and  (atessa ?r)
                (increase (reserves-ateses) 5)
                (forall (?d - dia)
                        (when (and (<= (reserva-diaInici ?r) (valor-dia ?d))   ; diaInici >= ?d
                                   (>= (reserva-diaFi    ?r) (valor-dia ?d)))  ; diaFi    <= ?d
                              (ocupada ?h ?d)
                        )
                )
          )
)


(:action ignorar
  :parameters (?r - reserva)
  :precondition (not(atessa ?r))
  :effect (and (atessa ?r) (increase (reserves-ateses) 1))
)
)
