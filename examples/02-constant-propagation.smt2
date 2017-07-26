; Set non zero verbosity so we can see `tactics`
; being executed
(set-option :verbose 10)
(declare-const foo (_ BitVec 8))
(declare-const bar (_ BitVec 8))
(assert
  (=
    foo
    #x01
  )
)
(assert
  (=
    foo
    bar
  )
)

; Apply the `propagate-value` tatic and show the result
; Note how `(= foo bar)` gets simplified to
; `(= #x01 bar)`
;
(apply (and-then propagate-values) :print_benchmark true :print false)
