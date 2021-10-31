#lang racket


(require r5rs)

(provide asa-make-coroutine
         asa-set-execute-function!
         asa-resume
         asa-yield)

(define (asa-make-coroutine) (cons #f (cons #f #f)))
(define (asa-function asa-coroutine) (car asa-coroutine))
(define (asa-resume-cc asa-coroutine) (cadr asa-coroutine))
(define (asa-yield-cc  asa-coroutine) (cddr asa-coroutine))


(define (asa-set-execute-function! asa-coroutine function) (set-car! asa-coroutine function))
(define (asa-set-resume-cc! asa-coroutine resume-cc) (set-car! (cdr asa-coroutine) resume-cc))
(define (asa-set-yield-cc! asa-coroutine yield-cc) (set-cdr! (cdr asa-coroutine) yield-cc))


(define (asa-resume asa-coroutine)
  (call/cc (lambda (yield)
             (asa-set-yield-cc! asa-coroutine yield)
             (if (false? (asa-resume-cc asa-coroutine))
                 ((asa-function asa-coroutine))
                 ((asa-resume-cc asa-coroutine))))))


(define (asa-yield asa-coroutine)
  (call/cc (lambda (resume)
             (asa-set-resume-cc! asa-coroutine resume)
             ((asa-yield-cc asa-coroutine)))))






