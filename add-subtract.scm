;Use addition and subtraction to calculate a set of numbers (lat), let their results equal the specified number i

(define sum
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else
       (+ (car lat) (sum (cdr lat)))))))

(define test-sum
  (sum (list 1 2 3 4 5)))

(define negative-sum
  (lambda (lat)
    (* -1 (sum lat))))

(define test-negative-sum
  (negative-sum (list 1 2 3 4)))

(define compute
  (lambda (i lat)
    (cond
      ;((null? lat) #f)
      ;((> i (sum lat)) #f)
      ;((< i (negative-sum lat)) #f)
      (else (recursion i lat (cons '= (cons i '())))))))

(define recursion
  (lambda (i lat str)
    (cond
      ((and (null? lat) (eq? i 0)) str)
      ((null? lat) #f)
      (else
       (or (xx i lat str '+)
           (xx i lat str '-)
           (xx i lat str '*)
           (xx i lat str '/))))))

(define xx
  (lambda (i lat str operator)
    (cond
      ((eq? operator '-) (let ((x (+ i (car lat)))) (recursion x (cdr lat) (cons '- (cons (car lat) str)))))
      ((eq? operator '+) (let ((x (- i (car lat)))) (recursion x (cdr lat) (cons '+ (cons (car lat) str)))))
;      ((eq? operator '/) (let ((x (* i (car lat)))) (recursion x (cdr lat) (cons '/ (cons (car lat) str)))))
;      ((eq? operator '*) (let ((x (/ i (car lat)))) (recursion x (cdr lat) (cons '* (cons (car lat) str)))))
      (else #f))))


       
;(define recursion
;  (lambda (i lat str)
;    (cond
;      ((and (null? lat) (eq? i 0)) str)
;      ((null? lat) #f)
;      (else
;       (or (xx i lat str '+)
;           (xx i lat str '-)
;           (xx i lat str '*)
;           (xx i lat str '/))))))
       
;(define recursion
;  (lambda (i lat str)
 ;   (cond
  ;    ((and (null? lat) (eq? i 0)) str)
   ;   ((null? lat) #f)
    ;  (else
     ;  (or (let ((x (+ i (car lat)))) (recursion x (cdr lat) (cons '- (cons (car lat) str))))
      ; (let ((x (- i (car lat)))) (recursion x (cdr lat) (cons '+ (cons (car lat) str)))))))))
  
(define t1
  (compute 9 (list 7 2 4)))

(define t2
  (compute 10 (list 1 2 3 4)))

(define t3
  (compute 10 (list 1 2 3 4 5)))
  
(define t4
  (cons 1 (cons 2 (cons 3 (cons 4 '())))))

(define t5
  (compute 0 '()))

(define t6
  (compute 100 (list 30 49 10 320 12 115 85 42 33 17 26 123)))

(define t7
  (compute -100 (list 30 49 10 320 12 115 85 42 33 17 26 123)))
