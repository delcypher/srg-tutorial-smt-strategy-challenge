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

; Example of using `(or-else ...)` combinator.
; We try to apply a custom tactic but if that fails
; we then try the `smt` tactic.
(check-sat-using
  (or-else
    (and-then simplify bit-blast sat fail-if-undecided)
    smt
  )
)
