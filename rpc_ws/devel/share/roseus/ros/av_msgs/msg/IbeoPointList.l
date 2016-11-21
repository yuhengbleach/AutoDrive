;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::IbeoPointList)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'IbeoPointList (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::IBEOPOINTLIST")
  (make-package "AV_MSGS::IBEOPOINTLIST"))

(in-package "ROS")
;;//! \htmlinclude IbeoPointList.msg.html


(defclass av_msgs::IbeoPointList
  :super ros::object
  :slots (_timestamp _ibeo_point_list ))

(defmethod av_msgs::IbeoPointList
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:ibeo_point_list __ibeo_point_list) (let (r) (dotimes (i 0) (push (instance av_msgs::IbeoPoint :init) r)) r))
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _ibeo_point_list __ibeo_point_list)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:ibeo_point_list
   (&rest __ibeo_point_list)
   (if (keywordp (car __ibeo_point_list))
       (send* _ibeo_point_list __ibeo_point_list)
     (progn
       (if __ibeo_point_list (setq _ibeo_point_list (car __ibeo_point_list)))
       _ibeo_point_list)))
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; av_msgs/IbeoPoint[] _ibeo_point_list
    (apply #'+ (send-all _ibeo_point_list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _timestamp
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestamp (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestamp) (= (length (_timestamp . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestamp . bv) 0) 0) s)
              (write-long (ash (elt (_timestamp . bv) 1) -1) s))
             ((and (class _timestamp) (= (length (_timestamp . bv)) 1)) ;; big1
              (write-long (elt (_timestamp . bv) 0) s)
              (write-long (if (>= _timestamp 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestamp s)(write-long (if (>= _timestamp 0) 0 #xffffffff) s)))
     ;; av_msgs/IbeoPoint[] _ibeo_point_list
     (write-long (length _ibeo_point_list) s)
     (dolist (elem _ibeo_point_list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _timestamp
     
#+(or :alpha :irix6 :x86_64)
      (setf _timestamp (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestamp (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; av_msgs/IbeoPoint[] _ibeo_point_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ibeo_point_list (let (r) (dotimes (i n) (push (instance av_msgs::IbeoPoint :init) r)) r))
     (dolist (elem- _ibeo_point_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get av_msgs::IbeoPointList :md5sum-) "5e8e53115c68cc8aab3056cdae033bf9")
(setf (get av_msgs::IbeoPointList :datatype-) "av_msgs/IbeoPointList")
(setf (get av_msgs::IbeoPointList :definition-)
      "uint64 timestamp
IbeoPoint[] ibeo_point_list

================================================================================
MSG: av_msgs/IbeoPoint
uint8 device_id
uint8 echo
uint16 flags
uint8 layer
float32 position_x
float32 position_y
float32 position_z

")



(provide :av_msgs/IbeoPointList "5e8e53115c68cc8aab3056cdae033bf9")


