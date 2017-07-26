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

; Applyging `simplify` tactic and then `smt` solver.
; This works without having to bit-blast. The `smt`
; solver is not not a boolean SAT solver and uses
; a different (often slower) approach.
; I'm not familar with the details but this tactic
; seems to be a "lazy" translation to SAT.
;
; See
; https://github.com/Z3Prover/z3/issues/1035#issuecomment-303160975
; http://satsmt2013.ics.aalto.fi/slides/Oliveras.pdf
(check-sat-using (and-then simplify smt))
