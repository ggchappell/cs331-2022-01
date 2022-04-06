#lang scheme
; eval.scm  UNFINISHED
; Glenn G. Chappell
; 2022-04-06
;
; For CS F331 / CSCE A331 Spring 2022
; Code from 4/6 - Scheme: Evaluation


(display "This file contains sample code from April 6, 2022,")
(newline)
(display "for the topic \"Scheme: Evaluation\".")
(newline)
(display "It will execute, but it is not intended to do anything")
(newline)
(display "useful. See the source.")
(newline)


; ***** Expressions *****


; Suppress evaluation: quote
; Try:
;   (+ 5 3)
;   (quote (+ 5 3))

; Leading single quote (') is syntactic sugar for a list beginning with
; quote.
; Try:
;   '(+ 5 3)
;   (quote (quote (a b c)))

; Evaluate arguments: eval
; Try:
;   (list "hello" '+ 1 2 3)
;   (eval (cdr (list "hello" '+ 1 2 3)))

; Call a procedure with given arguments: apply
; Try:
;   (apply + '(1 2 3))


; ***** Closures *****


; TODO: WRITE SOMETHING HERE!!!


; ***** Laziness *****


; We create lazy lists as follows: construct a list as usual, from pairs
; and null, but wherever there is a pair, its two elements are promises
; wrapping the first item in the list and the lazy list of the rest of
; the items. Note that, unlike ordinary Scheme lists, a lazy list may be
; infinite.

; countfrom
; Given a number, return an infinite lazy list (see above) with items
; k, k+1, k+2, etc.
(define (countfrom k)
  (cons (delay k) (delay (countfrom (+ 1 k))))
  )

; posints
; Infinite lazy list (see above) with items 1, 2, 3, etc.
(define posints (countfrom 1))

; ff
; Given two numbers a, b, return an infinite lazy list (see above) whose
; first two items are a, b, and each subsequent item is the sum of the
; previous two: a, b, a+b, a+2b, 2a+3b, etc.
(define (ff a b)
  (cons (delay a) (delay (ff b (+ a b))))
  )

; fibos, lucas
; Infinite lazy lists (see above) of all Fibonacci numbers and all Lucas
; numbers, respectively.
(define fibos (ff 0 1))
(define lucas (ff 2 1))

; take
; Given a number "count" and a list or lazy list (see above). Returns a
; regular (non-lazy) list of the first count items.
(define (take count lxs)
  (cond
    [(<= count 0)    null]
    [(null? lxs)     null]
    [(pair? lxs)     (cons (force (car lxs))
                           (take (- count 1) (force (cdr lxs)))
                           )
                     ]
    [else            (error "printit: arg #2 has bad type")]
    )
  )

; Try:
;   (take 5 '(1 2 3 4 5 6 7 8 9))
;   (take 100 posints)
;   (take 20 fibos)
;   (take 20 lucas)

