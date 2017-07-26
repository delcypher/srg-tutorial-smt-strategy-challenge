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
; Uncomment one of the `(apply ...)` commands

; Apply the `simplify` tatic and show the resulting goal
; Note how `(bvadd #x00 #x01)` gets simplified to
; `(bvadd #x01)`
;
;(apply (and-then simplify))

; Show the resulting goal as an SMT-LIB benchmark
;(apply (and-then simplify) :print_benchmark true :print false)

; Show statistics after running tactic
;(apply (and-then simplify) :print_statistics true)

; Run with timeout (in milliseconds)
; Use a different tactic because `simplify` runs too quickly.
;(apply (and-then smt) :timeout 1)
