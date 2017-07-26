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

; Example of using `(par-or ...)` combinator.
; This is similar to `(or-else ...)` except that the
; tactics are executed in parallel and the result of
; of the first tactic not to fail is used.
(check-sat-using
  (par-or
    (and-then simplify bit-blast sat fail-if-undecided)
    smt
  )
)
