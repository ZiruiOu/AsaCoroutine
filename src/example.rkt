#lang racket

(require r5rs)
(require "asa.rkt")

(define my-coroutine (asa-make-coroutine))
(define (my-function)
  (displayln "Hello, World!")
  (asa-yield my-coroutine)
  (displayln "This is my-function talking. Wish you have a nice day!")
  (asa-yield my-coroutine)
  (displayln "Good bye!"))
(asa-set-execute-function! my-coroutine my-function)

(asa-resume my-coroutine)
(asa-resume my-coroutine)
(asa-resume my-coroutine)