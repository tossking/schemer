(define add1
  (lambda (x)
    (+ 1 x)))

(define sub1
  (lambda (x)
    (- x 1)))

(define a-pair?
  (lambda (x)
    (cond
      ((null? x) #f)
      ((atom? x) #f)
      ((null? (cdr x)) #f)
      ((null? (cdr (cdr x))) #t)
      (else #f))))

(define first
  (lambda (p)
    (car p)))
(define second
  (lambda (p)
    (car (cdr p))))
(define third
  (lambda (p)
    (car (cdr (cdr p)))))
(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 (quote ())))))

(define fun?
  (lambda (rel)
    (set? (firsts rel))))

(define test_fun?
  (car (cdr (car (cons (cons 1 (cons 2 (quote ()))) (quote ()))))))

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)) (not (list? x)))))

(define bigger
  (lambda (x y)
    (cond
      ((zero? x) #f)
      ((zero? y) #t)
      (else (bigger (sub1 x) (sub1 y))))))

(define test_bigger
  (bigger 5 5))

(define test_bigger2
  (bigger 3 4))

(define test_bigger3
  (bigger 5123 2423));;;test function in <<little scheme>> chapter 2


;;(define can_firsts
;;	(lambda (l)
;;		(cond 
;;			((null? l) #t)
;;			((list? (car l)) (can_firsts (cdr l)))
;;			(else #f)
;;		)
;;	)
;;)

(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ;	((null? (car l)) (quote ()))
      (else (cons (car (car l)) (firsts (cdr l))))
      )
    )
  )

(define test_firsts
  (firsts (list (list 1 2) (list 3 4))))

(define insertg
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) (quote()))
        ((test? old (car l)) (cons old (cons new (cdr l))))
        (else (cons (car l) ((insertg test?) new old (cdr l))))))))
(define insert-g
  (lambda (seq)
    (lambda (new old l)
      (cond
        ((null? l) (quote()))
        ((eq? old (car l)) (seq new old (cdr l)))
        (else (cons (car l) ((insert-g seq) new old (cdr l))))))))
(define seqrem
  (lambda (new old l)
    l))
(define yyy
  (lambda (a l)
    ((insert-g seqrem) #f a l)))
(define test_yyy
  (yyy 3 (list 1 2 3 4 3 2 1 3 2 1)))

(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      ((eq? old (car lat)) (cons old (cons new (cdr lat))))
      (else (cons (car lat) (insertR new old (cdr lat))))
      )
    )
  )

(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      ((eq? old (car lat)) (cons new lat))
      (else (cons (car lat) (insertL new old (cdr lat))))
      )
    )
  )

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) (quote()))
      ((atom? (car l))
       (cond
         ((eq? old (car l)) (cons old (cons new (insertR* new old (cdr l)))))
         (else (cons (car l) (insertR* new old (cdr l))))))
      (else (cons (insertR* new old (car l)) (insertR* new old (cdr l)))))))

(define test_insertR*
  (insertR* 4 3 (list 1 2 3 5 3 3 3 (list 1 2 3) (list (list (list 1 2 3))))))


(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      ((eq? old (car lat)) (cons new (cdr lat)))
      (else (cons (car lat) (subst new old (cdr lat))))
      )
    )
  )

(define test_insertR
  (insertR 4 3 (list 1 2 3 5)))

(define test_insertL
  (insertL 4 5 (list 1 2 3 5)))

(define test_subst
  (subst 4 5 (list 1 2 3 5)))

(define mutiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote()))
      ((eq? old (car lat)) (cons old (cons new (mutiinsertR new old (cdr lat)))))
      (else (cons (car lat) (mutiinsertR new old (cdr lat))))
      )
    )
  )

(define test_mutiinsertR
  (mutiinsertR 4 3 (list 1 2 3 5 3 3 3)))

(define lat?
  (lambda (x)
    (cond 
      ((null? x) #t)
      ((atom? (car x)) (lat? (cdr x)))
      (else #f)
      )
    )
  )

(define test_lat?
  (and (lat? ())
       (lat? (list 1 2 3 4))
       (not (lat? (list 1 (cons 1 2))))))

(define length? 
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length? (cdr lat)))))))

(define test_length?
  (length? (list 1 2 3 4 5 6)))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(define test_pick
  (pick 4 (list 1 2 3 4 5 6)))

(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))

(define keep-looking
  (lambda (a sorn lat)
    (cond
      ((number? sorn) (keep-looking a (pick sorn lat) lat))
      (else (eq? sorn a)))))

(define test_looking
  (looking "apple" (list 6 2 4 "apple" 5 7 3)))

(define test_looking2
  (looking "apple" (list 6 2 "orange" "apple" 5 7 3)))

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a) (member? a(cdr lat)))))))

(define test_member
  (member? 3 (list 1 2 3 4)))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))))))

(define test_no-nums
  (no-nums (list 1 2 3 4 "a" "b" "c" 5 6 7 "d")))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))

(define test_all-nums
  (all-nums (list 1 2 3 4 "a" "b" "c" 5 6 7 "d")))

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? a (car lat)) (+ 1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))

(define test_occur
  (occur 1 (list 1 2 3 4 1 "a" "b" "c" 1)))

;(define test2
;  (pick 7 (list 1 2 3 4 5 6)))
(define power
  (lambda (x y)
    (cond
      ((zero? y) 1)
      (else (* x (power x (- y 1)))))))

(define test_power
  (power 3 3))

(define test_power2
  (power 10 10))

(define rember*
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((equal? a (car l)) (rember* a (cdr l)))
         (else (cons (car l) (rember* a (cdr l))))))
      (else (cons (rember* a (car l)) (rember* a (cdr l)))))))

(define test_rember*
  (rember* 3 (list 1 2 3 4 5 4 3 2 1 3)))
(define test_rember*2
  (rember* 3 (list 1 2 3 4 5 (list 6 7 6 5 (list 4 3)) 2 1)))
(define test_rember*3
  (rember* "a" (list "a" "b" "c" 1 2 3 (list "a" 4) 5 "d" (list (list (list "e" "f" "a" 6))))))

(define rember
  (lambda (a l)
    (cond
      ;;;	((atom? a) l)
      ((null? l) ())
      ((eq? a (car l)) (cdr l))
      (else (cons (car l) (rember a (cdr l)))))))

(define t0
  (rember 1 ()))

(define t1
  (rember 1 (list 1 2 3 4)))

(define t2
  (rember 2 (list 1 2 3 4)))

(define t3
  (rember 3 (list 1 2 3 4)))

(define t4
  (rember 4 (list 1 2 3 4)))

(define mutirember
  (lambda (a lat)
    (cond
      ((null? lat) ())
      ((eq? a (car l)) (mutirember (cdr l)))
      (else (cons (car l) (mutirember a (cdr l)))))))

(define test_mutirember
  (rember 3 (list 1 2 3 4 3 2 1 3 2 1)))

(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))

(define test_set?
  (set? (list 1 2 3 4 5 6 7 2 3 4 5 6 6 8 9 7 7 7)))

(define make_set
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((member? (car lat) (cdr lat)) (make_set (cdr lat)))
      (else (cons (car lat) (make_set (cdr lat)))))))

(define test_make_set
  (make_set (list 1 2 3 4 5 6 7 2 3 4 5 6 6 8 9 7 7 7 8)))

(define make_set2
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      (else (cons (car lat) (make_set2 (rember* (car lat) (cdr lat))))))))


(define test_make_set2
  (make_set2 (list 1 2 3 4 5 6 7 2 3 4 5 6 6 8 9 7 7 7 8)))

(define test_make_set3
  (make_set2 (list "apple" 3 "pear" 4 9 "apple" 3 4)))

(define shift
  (lambda (x)
    (cond
      ((null? x) (quote ()))
      (else (build (first (first x)) (build (second (first x)) (second x)))))))
;	(else (cons (car (car x)) (cons (cons (car (cdr (car x))) (cons (car (cdr x)) (quote ()))) (quote ())))))))

(define test_shift
  (shift (list (list 1 2) 3)))

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else (and (member? (car set1) set2)
                 (subset? (cdr set1) set2))))))

(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2) (subset? set2 set1))))


