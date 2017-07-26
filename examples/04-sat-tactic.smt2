; Set non zero verbosity so we can see `tactics`
; being executed
(set-option :verbose 10)
(declare-const foo (_ BitVec 8))
(declare-const bar (_ BitVec 8))
(assert
  (=
    foo
    (bvadd
      bar
      #x01
    )
  )
)

; Uncomment one of the sequences of commands below


; Applyging `simplify` tactic and then `sat` solver.
; This doesn't work (reports `unknown`) because `sat`
; tactic can't work on bitvectors directly.
;(check-sat-using (and-then simplify sat))

; We can apply the `bit-blast` tactic to convert into
; a boolean satisfiability problems. The `(apply ...)`
; command below will show result of applying the `simplify`
; and then the `bit-blast` tactic.
;(apply (and-then simplify bit-blast) :print false :print_benchmark true)


; Now determine satisfiability by applying the
; `simplify`, `bit-blast`, and `sat` tactics in order.
;(check-sat-using (and-then simplify bit-blast sat))
;(get-model)
