#lang scheme
; data.scm
; Glenn G. Chappell
; 2022-04-08
;
; For CS F331 / CSCE A331 Spring 2022
; Code from 4/8 - Scheme: Data


(display "This file contains sample code from April 8, 2022,")
(newline)
(display "for the topic \"Scheme: Data\".")
(newline)
(display "It will execute, but it is not intended to do anything")
(newline)
(display "useful. See the source.")
(newline)


; ***** Equality *****


; Type-specific comparisons
; Try:
;   (string=? "abc" "abc")
;   (string=? "abc" "def")
;   (string=? 42 42)
;   (string<? "abc" "def")
;   (char=? #\A #\B)

; General comparisons: eq? (same location in memory)
; Try:
;   (eq? '() '())
;   (define a '(1 2))
;   (eq? a '(1 2))
;   (define b a)
;   (eq? a b)

; General comparisons: eqv? (same primitive value)
; Try:
;   (eqv? 2 2)
;   (eqv? 2 2.0)
;   (define a '(1 2))
;   (eqv? a '(1 2))

; General comparisons: equal?
; Try:
;   (equal? "abc" "abc")
;   (equal? "abc" "def")
;   (equal? #\A #\A)
;   (equal? #\A "A")
;   (define a '(1 2))
;   (equal? a '(1 2))

; Watch out for numbers.
; Try:
;   (= 2 2.0)
;   (equal? 2 2.0)


; ***** Data Format *****


; Dot notation creates a pair literal.
; Try:
;   '(1 . 2)

; List notation is shorthand.
; Try:
;   '(1 . (2 . (3 . (4 . ()))))

; car & cdr are really about pairs, not lists.
; Try:
;   (car '(1 . 2))
;   (cdr '(1 . 2))

; Dot may be used before the last item in a list-like construction.
; Try:
;   '(1 2 3 4 5 . 6)
;   '(1 . (2 . (3 . (4 . (5 . 6)))))


; ***** Varying Number of Parameters *****


; add
; Just like +.
(define (add . args)
  (cond
    [(null? args)        0]
    [(not (pair? args))  (error "add: args do not form a list")]
    [else                (+ (car args) (apply add (cdr args)))]
    )
  )

; Try:
;   (add 3 6)
;   (add 1 2 3 4 5 6)
;   (add 42)
;   (add)


; ***** Manipulating Trees *****


; atomsum
; Return the sum of all the atoms in a tree. All atoms must be numbers.
(define (atomsum t)
  (cond
    [(null? t)   0]
    [(pair? t)   (+ (atomsum (car t)) (atomsum (cdr t)))]
    [(number? t) t]
    [else        (error "atomsum: atom is not a number")]
    )
  )

; Try:
;   (atomsum '(1 (3 (5) ((7 9))) 11 (((13))) () (15)))
;   (atomsum '(20 "abc"))

; atommap
; Given a one-parameter procedure and a tree, return the tree with each
; atom replaced by (f atom).
(define (atommap f t)
  (cond
    [(null? t)   null]
    [(pair? t)   (cons (atommap f (car t)) (atommap f (cdr t)))]
    [else        (f t)]  ; Error if f cannot be called with t
    )
  )

; Try:
;   (atommap sqr '(1 (2 (3) ((4))) () (5)))

