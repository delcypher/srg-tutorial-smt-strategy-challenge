; Set non zero verbosity so we can see `tactics`
; being executed
(set-option :verbose 10)
(declare-const foo (_ BitVec 8))
(declare-const bar (_ BitVec 8))
(declare-const baz (_ BitVec 8))
(declare-const a Int)
(assert
  (=
    foo
    (bvadd
      bar
      #x01
    )
  )
)
(assert
  (bvugt
    foo
    baz
  )
)

; Uncomment this to make the query no longer
; be in the QF_BV logic.
;(assert (>= a 0))

; Uncomment one of the `(check-sat-using ...)`
; commands below.

; Apply probe `is-qfbv` which is true if the query
; is in the QF_BV logic (quantifier free bitvectors).
;
; If the probe is true we apply a simple tactic
; for QF_BV otherwise we apply the `fail`
; tactic which just fails.
;(check-sat-using (if is-qfbv (and-then simplify bit-blast sat) fail))


;(check-sat-using (if is-qfbv qfbv smt))
