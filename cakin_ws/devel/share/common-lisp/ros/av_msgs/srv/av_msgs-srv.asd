
(cl:in-package :asdf)

(defsystem "av_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :av_msgs-msg
)
  :components ((:file "_package")
    (:file "getPointOnRoad" :depends-on ("_package_getPointOnRoad"))
    (:file "_package_getPointOnRoad" :depends-on ("_package"))
    (:file "getLocalLanemarkers" :depends-on ("_package_getLocalLanemarkers"))
    (:file "_package_getLocalLanemarkers" :depends-on ("_package"))
  ))