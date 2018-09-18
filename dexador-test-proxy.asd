(in-package :cl-user)
(defpackage dexador-test-proxy-asd
  (:use :cl :asdf))
(in-package :dexador-test-proxy-asd)

(defsystem dexador-test-proxy
  :author "tamura shingo"
  :license "MIT"
  :depends-on (:dexador
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "proxy"))))

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
