;; -*- lisp -*-

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :cl-cidr-notation.system)
    (defpackage :cl-cidr-notation.system (:use :common-lisp :asdf))))

(in-package :cl-cidr-notation.system)

(defsystem :cl-cidr-notation
  :description "A library providing functions to read and write CIDR IP address notation"
  :licence "BSD"
  :version "0.2"
  :serial t
  :components ((:module :src
                :serial t
                :components ((:file "packages")
                             (:file "cl-cidr-notation")
                             (:file "cl-ipv6-notation"))))
  :depends-on (:cl-ppcre
               :symbol-munger))

(defsystem :cl-cidr-notation-test
  :description "Tests for the cl-cidr-notation library"
  :licence "BSD"
  :version "0.2"
  :serial t
  :components ((:module :test
                        :serial t
                        :components ((:file "packages")
                                     (:file "cl-cidr-notation"))))
  :depends-on (:cl-cidr-notation
               :lisp-unit2))

(defmethod asdf:perform ((o asdf:test-op) (c (eql (find-system :cl-cidr-notation))))
  (asdf:oos 'asdf:load-op :cl-cidr-notation-test)
  (let ((*package* (find-package :cl-cidr-notation-test)))
    (eval (read-from-string
           "(lisp-unit2:run-tests
             :name :cl-cidr-notation
             :package :cl-cidr-notation-test
             :run-contexts #'lisp-unit2:with-summary-context)"))))
