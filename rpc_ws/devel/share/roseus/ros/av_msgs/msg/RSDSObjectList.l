;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::RSDSObjectList)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'RSDSObjectList (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::RSDSOBJECTLIST")
  (make-package "AV_MSGS::RSDSOBJECTLIST"))

(in-package "ROS")
;;//! \htmlinclude RSDSObjectList.msg.html


(defclass av_msgs::RSDSObjectList
  :super ros::object
  :slots (_timestamp _radar_object_list _ori_msg ))

(defmethod av_msgs::RSDSObjectList
  (:init
   (&key
    ((:timestamp __timestamp) 0)
    ((:radar_object_list __radar_object_list) (let (r) (dotimes (i 0) (push (instance av_msgs::RSDSObject :init) r)) r))
    ((:ori_msg __ori_msg) (make-array 1240 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _timestamp (round __timestamp))
   (setq _radar_object_list __radar_object_list)
   (setq _ori_msg __ori_msg)
   self)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:radar_object_list
   (&rest __radar_object_list)
   (if (keywordp (car __radar_object_list))
       (send* _radar_object_list __radar_object_list)
     (progn
       (if __radar_object_list (setq _radar_object_list (car __radar_object_list)))
       _radar_object_list)))
  (:ori_msg
   (&optional __ori_msg)
   (if __ori_msg (setq _ori_msg __ori_msg)) _ori_msg)
  (:serialization-length
   ()
   (+
    ;; uint64 _timestamp
    8
    ;; av_msgs/RSDSObject[] _radar_object_list
    (apply #'+ (send-all _radar_object_list :serialization-length)) 4
    ;; uint8[1240] _ori_msg
    (* 1    1240)
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
     ;; av_msgs/RSDSObject[] _radar_object_list
     (write-long (length _radar_object_list) s)
     (dolist (elem _radar_object_list)
       (send elem :serialize s)
       )
     ;; uint8[1240] _ori_msg
     (princ _ori_msg s)
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
   ;; av_msgs/RSDSObject[] _radar_object_list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _radar_object_list (let (r) (dotimes (i n) (push (instance av_msgs::RSDSObject :init) r)) r))
     (dolist (elem- _radar_object_list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint8[1240] _ori_msg
   (setq _ori_msg (make-array 1240 :element-type :char))
   (replace _ori_msg buf :start2 ptr-) (incf ptr- 1240)
   ;;
   self)
  )

(setf (get av_msgs::RSDSObjectList :md5sum-) "7d986c7de0623b45f1b9ae898cef8ac3")
(setf (get av_msgs::RSDSObjectList :datatype-) "av_msgs/RSDSObjectList")
(setf (get av_msgs::RSDSObjectList :definition-)
      "uint64 timestamp
RSDSObject[] radar_object_list
uint8[1240] ori_msg

================================================================================
MSG: av_msgs/RSDSObject
uint64 id # object id
float32 x_pos 
float32 x_vel
float32 x_acc
float32 y_pos
float32 y_vel
float32 y_acc
int32 tracker_status
int32 station_flags


")



(provide :av_msgs/RSDSObjectList "7d986c7de0623b45f1b9ae898cef8ac3")


