; Set non zero verbosity so we can see `tactics`
; being executed
(set-option :verbose 10)
(declare-const foo (_ BitVec 8))
(assert
  (=
    foo
    (bvadd
      #x00
      #x01
    )
  )
)
; Uncomment one of the `(check-sat ...)` commands

; Apply the `simplify` tactic to try to check satisfiability
; this will fail (Z3 reports `unknown`) because the `simplify`
; tactic just simplifies expressions. The simplification performed
; here doesn't result in trivial satisfiability.
;
;(check-sat-using (and-then simplify))

; Show statistics after running tactic
;(check-sat-using (and-then simplify) :print_statistics true)

; Run with timeout (in milliseconds)
; Use a different tactic because `simplify` runs too quickly.
;(check-sat-using (and-then smt) :timeout 1)
