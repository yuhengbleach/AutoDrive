;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::IbeoObjectList)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'IbeoObjectList (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::IBEOOBJECTLIST")
  (make-package "AV_MSGS::IBEOOBJECTLIST"))

(in-package "ROS")
;;//! \htmlinclude IbeoObjectList.msg.html


(defclass av_msgs::IbeoObjectList
  :super ros::object
  :slots (_timestamp _ibeo_object_list ))

(defmethod av_msgs::IbeoObjectList
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:ibeo_object_list __ibeo_object_list) (let (r) (dotimes (i 0) (push (instance av_msgs::IbeoObject :init) r)) r))
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _ibeo_object_list __ibeo_object_list)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:ibeo_object_list
   (&rest __ibeo_object_list)
   (if (keywordp (car __ibeo_object_list))
       (send* _ibeo_object_list __ibeo_object_list)
     (progn
       (if __ibeo_object_list (setq _ibeo_object_list (car __ibeo_object_list)))
       _ibeo_object_list)))
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; av_msgs/IbeoObject[] _ibeo_object_list
    (apply #'+ (send-all _ibeo_object_list :serialization-length)) 4
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
     ;; av_msgs/IbeoObject[] _ibeo_object_list
     (write-long (length _ibeo_object_list) s)
     (dolist (elem _ibeo_object_list)
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
   ;; av_msgs/IbeoObject[] _ibeo_object_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ibeo_object_list (let (r) (dotimes (i n) (push (instance av_msgs::IbeoObject :init) r)) r))
     (dolist (elem- _ibeo_object_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get av_msgs::IbeoObjectList :md5sum-) "981f29f62d860aaf5829de1d977ef990")
(setf (get av_msgs::IbeoObjectList :datatype-) "av_msgs/IbeoObjectList")
(setf (get av_msgs::IbeoObjectList :definition-)
      "uint64 timestamp
IbeoObject[] ibeo_object_list

================================================================================
MSG: av_msgs/IbeoObject
uint16 object_id
float32 object_box_center_x
float32 object_box_center_y
float32 object_box_length
float32 object_box_width
float32 object_box_orientation
float32 relative_velocity_x
float32 relative_velocity_y
float32 relative_velocity_sigma_x
float32 relative_velocity_sigma_y
uint8 object_class
float32 object_class_certainty
float32 exist_measurement



")



(provide :av_msgs/IbeoObjectList "981f29f62d860aaf5829de1d977ef990")


