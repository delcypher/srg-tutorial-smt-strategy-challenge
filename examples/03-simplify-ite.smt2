(declare-const foo (_ BitVec 8))
(declare-const bar (_ BitVec 8))
(declare-const cond Bool)
(assert
  (=
    foo
    (ite cond
      (bvadd bar #x01)
      (bvadd bar #x03)
    )
  )
)

; Comment out one of the `(apply ...)` commands below

; Apply the `simplify` tatic and show the result
; Note how the assertion remains unchanged.
;
;(apply (and-then simplify) :print_benchmark true :print false)


; We'd like to push down the `ite` so we only have a single application
; of the `bvadd` function. The `simplify` tactic doesn't do this by
; default but we can change one of its parameters to enable this
; transformation. If you look at the output of
;
; ```
; ./z3 <(echo "(help-tactic)") | less
; ```
;
; You can see the parameters of all the tactics including the `simplify`
; tactic. The `push_ite_bv` parameter (false by default) can be enabled
; to allow `ite` applications to be pushed down when are over bitvector
; arithmetic functions. We can set this parameter using the
; `(using-params ...)` syntax as shown below.
;
; Note how the assert becomes
;
; ```
; (assert (= foo (bvadd (ite cond #x01 #x03) bar)))
; ```
;(apply (and-then (using-params simplify :push_ite_bv true)) :print_benchmark true :print false)
