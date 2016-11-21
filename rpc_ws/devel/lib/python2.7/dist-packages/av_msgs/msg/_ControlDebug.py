# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from av_msgs/ControlDebug.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class ControlDebug(genpy.Message):
  _md5sum = "7d5523c0fa27208129ad6a5de3491e13"
  _type = "av_msgs/ControlDebug"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """#longitudinal
float64 desired_velocity
float64 current_velocity

#lateral 
float64 e_pose
float64 e_angle

"""
  __slots__ = ['desired_velocity','current_velocity','e_pose','e_angle']
  _slot_types = ['float64','float64','float64','float64']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       desired_velocity,current_velocity,e_pose,e_angle

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(ControlDebug, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.desired_velocity is None:
        self.desired_velocity = 0.
      if self.current_velocity is None:
        self.current_velocity = 0.
      if self.e_pose is None:
        self.e_pose = 0.
      if self.e_angle is None:
        self.e_angle = 0.
    else:
      self.desired_velocity = 0.
      self.current_velocity = 0.
      self.e_pose = 0.
      self.e_angle = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_struct_4d.pack(_x.desired_velocity, _x.current_velocity, _x.e_pose, _x.e_angle))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      end = 0
      _x = self
      start = end
      end += 32
      (_x.desired_velocity, _x.current_velocity, _x.e_pose, _x.e_angle,) = _struct_4d.unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_struct_4d.pack(_x.desired_velocity, _x.current_velocity, _x.e_pose, _x.e_angle))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      end = 0
      _x = self
      start = end
      end += 32
      (_x.desired_velocity, _x.current_velocity, _x.e_pose, _x.e_angle,) = _struct_4d.unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
_struct_4d = struct.Struct("<4d")