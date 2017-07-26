; Set non zero verbosity so we can see `tactics`
; being executed
(set-option :verbose 10)

; This is a query taken from my fork of KLEE that handles
; floating point constraints.

(declare-fun f0 () (Array (_ BitVec 32) (_ BitVec 8)))
(assert
 (let ((?x15 (concat (select f0 (_ bv2 32)) (concat (select f0 (_ bv1 32)) (select f0 (_ bv0 32))))))
 (let ((?x24 (concat (select f0 (_ bv5 32)) (concat (select f0 (_ bv4 32)) (concat (select f0 (_ bv3 32)) ?x15)))))
 (let ((?x31 ((_ to_fp 11 53) (concat (select f0 (_ bv7 32)) (concat (select f0 (_ bv6 32)) ?x24)))))
 (not (fp.isNaN ?x31))))))
(assert
 (let ((?x15 (concat (select f0 (_ bv2 32)) (concat (select f0 (_ bv1 32)) (select f0 (_ bv0 32))))))
(let ((?x24 (concat (select f0 (_ bv5 32)) (concat (select f0 (_ bv4 32)) (concat (select f0 (_ bv3 32)) ?x15)))))
(let ((?x31 ((_ to_fp 11 53) (concat (select f0 (_ bv7 32)) (concat (select f0 (_ bv6 32)) ?x24)))))
(let ((?x41 (fp.sqrt roundNearestTiesToEven (fp.mul roundNearestTiesToEven ?x31 ?x31))))
(let ((?x47 (fp.mul roundNearestTiesToEven ?x41 ((_ to_fp 11 53) (_ bv4607092346807469998 64)))))
(let ((?x34 (fp.abs ?x31)))
(let (($x43 (or (fp.isNaN (fp.mul roundNearestTiesToEven ?x34 ((_ to_fp 11 53) (_ bv4607092346807469998 64)))) (fp.isNaN ?x41))))
(let (($x45 (or $x43 (fp.gt (fp.mul roundNearestTiesToEven ?x34 ((_ to_fp 11 53) (_ bv4607092346807469998 64))) ?x41))))
(not (or $x45 (or (or (fp.isNaN ?x34) (fp.isNaN ?x47)) (fp.lt ?x34 ?x47)))))))))))))

; Z3 at commit (0f1583309d0813e87d6003fe46cf8bb32899d773) is very slow
; on this query. The use of arrays prevents bit-blasting to the fast
; sat solver so the slower `smt` tactic gets used.
;(check-sat)

; Rewrite arrays as application of uninterpreted functions
;(apply (and-then simplify bvarray2uf) :print false :print_benchmark true)

; Rewrite arrays as application of uninterpreted functions and then try
; to ackermannize them.
;(apply (and-then simplify bvarray2uf ackermannize_bv) :print false :print_benchmark true)


; As a solving tactic
(check-sat-using
  (and-then
    simplify
    (or-else
      (and-then
        (using-params bvarray2uf :produce_models true)
        (using-params ackermannize_bv :div0_ackermann_limit 1000000)
        (if is-qffpbv qffpbv fail)
      )
      qfaufbv
    )
  )
)
(get-value ((select f0 (_ bv0 32))))
(get-value ((select f0 (_ bv1 32))))
(get-value ((select f0 (_ bv2 32))))
(get-value ((select f0 (_ bv3 32))))
(get-value ((select f0 (_ bv4 32))))
(get-value ((select f0 (_ bv5 32))))
(get-value ((select f0 (_ bv6 32))))
(get-value ((select f0 (_ bv7 32))))
(get-value ((select f0 (_ bv8 32))))
