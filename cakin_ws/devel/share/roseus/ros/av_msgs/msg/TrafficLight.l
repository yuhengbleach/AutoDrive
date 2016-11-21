;; Auto-generated. Do not edit!


(when (boundp 'av_msgs::TrafficLight)
  (if (not (find-package "AV_MSGS"))
    (make-package "AV_MSGS"))
  (shadow 'TrafficLight (find-package "AV_MSGS")))
(unless (find-package "AV_MSGS::TRAFFICLIGHT")
  (make-package "AV_MSGS::TRAFFICLIGHT"))

(in-package "ROS")
;;//! \htmlinclude TrafficLight.msg.html


(defclass av_msgs::TrafficLight
  :super ros::object
  :slots (_id _type _status _time _confidence ))

(defmethod av_msgs::TrafficLight
  (:init
   (&key
    ((:id __id) 0)
    ((:type __type) 0)
    ((:status __status) 0)
    ((:time __time) 0)
    ((:confidence __confidence) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _type (round __type))
   (setq _status (round __status))
   (setq _time (round __time))
   (setq _confidence (float __confidence))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:time
   (&optional __time)
   (if __time (setq _time __time)) _time)
  (:confidence
   (&optional __confidence)
   (if __confidence (setq _confidence __confidence)) _confidence)
  (:serialization-length
   ()
   (+
    ;; uint8 _id
    1
    ;; uint8 _type
    1
    ;; uint8 _status
    1
    ;; uint8 _time
    1
    ;; float32 _confidence
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _id
       (write-byte _id s)
     ;; uint8 _type
       (write-byte _type s)
     ;; uint8 _status
       (write-byte _status s)
     ;; uint8 _time
       (write-byte _time s)
     ;; float32 _confidence
       (sys::poke _confidence (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _id
     (setq _id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _time
     (setq _time (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _confidence
     (setq _confidence (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get av_msgs::TrafficLight :md5sum-) "12e6ff6aa826247c71e4c2bc2f9e6414")
(setf (get av_msgs::TrafficLight :datatype-) "av_msgs/TrafficLight")
(setf (get av_msgs::TrafficLight :definition-)
      "uint8 id
#交通灯ID
uint8 type
#圆形1 左转2 直行3 右转4 左转掉头5 掉头6
uint8 status
#红1 绿2 黄3
uint8 time
#当前状态倒数数字
float32 confidence
#置信度

")



(provide :av_msgs/TrafficLight "12e6ff6aa826247c71e4c2bc2f9e6414")


