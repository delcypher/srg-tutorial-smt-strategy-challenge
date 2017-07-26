; Set non zero verbosity so we can see `tactics`
; being executed
(set-option :verbose 10)

; Don't worry about what this query does.
;
; It's a query I know executes slowly for the `smt` tactic
; but can be solved much quicker using the `qffpbv` tactic
;
(declare-fun f0 () (_ BitVec 64))
(assert
 (let ((?x31 ((_ to_fp 11 53) f0)))
 (not (fp.isNaN ?x31))))
(assert
(let ((?x31 ((_ to_fp 11 53) f0)))
(let ((?x41 (fp.sqrt roundNearestTiesToEven (fp.mul roundNearestTiesToEven ?x31 ?x31))))
(let ((?x47 (fp.mul roundNearestTiesToEven ?x41 ((_ to_fp 11 53) (_ bv4607092346807469998 64)))))
(let ((?x34 (fp.abs ?x31)))
(let (($x43 (or (fp.isNaN (fp.mul roundNearestTiesToEven ?x34 ((_ to_fp 11 53) (_ bv4607092346807469998 64)))) (fp.isNaN ?x41))))
(let (($x45 (or $x43 (fp.gt (fp.mul roundNearestTiesToEven ?x34 ((_ to_fp 11 53) (_ bv4607092346807469998 64))) ?x41))))
(not (or $x45 (or (or (fp.isNaN ?x34) (fp.isNaN ?x47)) (fp.lt ?x34 ?x47)))))))))))

; Very slow
;(check-sat-using (and-then smt))

; Much faster
;(check-sat-using (and-then qffpbv))

; Example of using `(try-for ...)`. In this example we try the `smt` tactic for
; a set amount of time and will fail if the time limit is reached. This is
; combined with the `(or-else ...)` combinator so that upon failure we try
; the `qffpbv` tactic instead.
(check-sat-using
  (or-else
    (try-for smt 4000)
    qffpbv
  )
)

