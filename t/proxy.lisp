(in-package :cl-user)
(defpackage dexador-test.proxy
  (:use :cl
        :prove))
(in-package :dexador-test.proxy)

(defparameter *NO-AUTH-PROXY* "http://localhost:8080")
(defparameter *AUTH-PROXY* "http://testuser:testpass@localhost:8081")

(defparameter *HTTP* "http://localhost:5000/181B.html")
(defparameter *HTTPS* "https://localhost:5001/181B.html")

(defparameter BODY
  "<!DOCTYPE html>
<html>
<head>
  <meta charset=\"utf-8\">
  <title>Hello, Dexador</title>
</head>
<body>
  Hello, Dexador. I'm not a Zenekindarl. Go back to your home.
</body>
</html>
")

(subtest "HTTP without proxy"
  (subtest "GET"
    (multiple-value-bind (body code headers)
        (dex:get *HTTP*)
      (is code 200)
      (is body BODY)

(subtest "HTTPS without proxy"
  (subtest "GET"
    (multiple-value-bind (body code headers)
        (dex:get *HTTPS*
                 :insecure T)
      (is code 200)
      (is body BODY)
      (is (gethash "content-length" headers) 181))))
      (is (gethash "content-length" headers) 181))))

(subtest "HTTP with no auth proxy"
  (subtest "GET"
    (multiple-value-bind (body code headers)
        (dex:get *HTTP*
                 :proxy *NO-AUTH-PROXY*)
      (is code 200)
      (is body BODY)
      (is (gethash "content-length" headers) 181))))

(subtest "HTTP with auth proxy"
  (subtest "GET"
    (multiple-value-bind (body code headers)
        (dex:get *HTTP*
                 :proxy *AUTH-PROXY*)
      (is code 200)
      (is body BODY)
      (is (gethash "content-length" headers) 181))))
      
(subtest "HTTPS with no auth proxy"
  (subtest "GET"
    (multiple-value-bind (body code headers)
        (dex:get *HTTPS*
                 :proxy *NO-AUTH-PROXY*
                 :insecure T)
      (is code 200)
      (is body BODY)
      (is (gethash "content-length" headers) 181))))

(subtest "HTTPS with auth proxy"
  (subtest "GET"
    (multiple-value-bind (body code headers)
        (dex:get *HTTPS*
                 :proxy *AUTH-PROXY*
                 :insecure T)
      (is code 200)
      (is body BODY)
      (is (gethash "content-length" headers) 181))))
