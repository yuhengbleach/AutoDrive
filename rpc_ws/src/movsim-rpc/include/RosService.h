/**
 * Autogenerated by Thrift Compiler (0.9.3)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
#ifndef RosService_H
#define RosService_H

#include <thrift/TDispatchProcessor.h>
#include <thrift/async/TConcurrentClientSyncInfo.h>
#include "ros_types.h"

namespace Ros {

#ifdef _WIN32
  #pragma warning( push )
  #pragma warning (disable : 4250 ) //inheriting methods via dominance 
#endif

class RosServiceIf {
 public:
  virtual ~RosServiceIf() {}
  virtual void getTrajectory(Trajectory& _return) = 0;
  virtual void publishFusionMap(const Fusionmap& fusion_map) = 0;
  virtual void publishTrafficLightDetect(const TrafficLightDetect& traffic_light_detect) = 0;
  virtual void publishLocalize(const Localize& localize) = 0;
  virtual void publishDest(const Dest& dest) = 0;
};

class RosServiceIfFactory {
 public:
  typedef RosServiceIf Handler;

  virtual ~RosServiceIfFactory() {}

  virtual RosServiceIf* getHandler(const ::apache::thrift::TConnectionInfo& connInfo) = 0;
  virtual void releaseHandler(RosServiceIf* /* handler */) = 0;
};

class RosServiceIfSingletonFactory : virtual public RosServiceIfFactory {
 public:
  RosServiceIfSingletonFactory(const boost::shared_ptr<RosServiceIf>& iface) : iface_(iface) {}
  virtual ~RosServiceIfSingletonFactory() {}

  virtual RosServiceIf* getHandler(const ::apache::thrift::TConnectionInfo&) {
    return iface_.get();
  }
  virtual void releaseHandler(RosServiceIf* /* handler */) {}

 protected:
  boost::shared_ptr<RosServiceIf> iface_;
};

class RosServiceNull : virtual public RosServiceIf {
 public:
  virtual ~RosServiceNull() {}
  void getTrajectory(Trajectory& /* _return */) {
    return;
  }
  void publishFusionMap(const Fusionmap& /* fusion_map */) {
    return;
  }
  void publishTrafficLightDetect(const TrafficLightDetect& /* traffic_light_detect */) {
    return;
  }
  void publishLocalize(const Localize& /* localize */) {
    return;
  }
  void publishDest(const Dest& /* dest */) {
    return;
  }
};


class RosService_getTrajectory_args {
 public:

  RosService_getTrajectory_args(const RosService_getTrajectory_args&);
  RosService_getTrajectory_args& operator=(const RosService_getTrajectory_args&);
  RosService_getTrajectory_args() {
  }

  virtual ~RosService_getTrajectory_args() throw();

  bool operator == (const RosService_getTrajectory_args & /* rhs */) const
  {
    return true;
  }
  bool operator != (const RosService_getTrajectory_args &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const RosService_getTrajectory_args & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};


class RosService_getTrajectory_pargs {
 public:


  virtual ~RosService_getTrajectory_pargs() throw();

  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _RosService_getTrajectory_result__isset {
  _RosService_getTrajectory_result__isset() : success(false) {}
  bool success :1;
} _RosService_getTrajectory_result__isset;

class RosService_getTrajectory_result {
 public:

  RosService_getTrajectory_result(const RosService_getTrajectory_result&);
  RosService_getTrajectory_result& operator=(const RosService_getTrajectory_result&);
  RosService_getTrajectory_result() {
  }

  virtual ~RosService_getTrajectory_result() throw();
  Trajectory success;

  _RosService_getTrajectory_result__isset __isset;

  void __set_success(const Trajectory& val);

  bool operator == (const RosService_getTrajectory_result & rhs) const
  {
    if (!(success == rhs.success))
      return false;
    return true;
  }
  bool operator != (const RosService_getTrajectory_result &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const RosService_getTrajectory_result & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _RosService_getTrajectory_presult__isset {
  _RosService_getTrajectory_presult__isset() : success(false) {}
  bool success :1;
} _RosService_getTrajectory_presult__isset;

class RosService_getTrajectory_presult {
 public:


  virtual ~RosService_getTrajectory_presult() throw();
  Trajectory* success;

  _RosService_getTrajectory_presult__isset __isset;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);

};

typedef struct _RosService_publishFusionMap_args__isset {
  _RosService_publishFusionMap_args__isset() : fusion_map(false) {}
  bool fusion_map :1;
} _RosService_publishFusionMap_args__isset;

class RosService_publishFusionMap_args {
 public:

  RosService_publishFusionMap_args(const RosService_publishFusionMap_args&);
  RosService_publishFusionMap_args& operator=(const RosService_publishFusionMap_args&);
  RosService_publishFusionMap_args() {
  }

  virtual ~RosService_publishFusionMap_args() throw();
  Fusionmap fusion_map;

  _RosService_publishFusionMap_args__isset __isset;

  void __set_fusion_map(const Fusionmap& val);

  bool operator == (const RosService_publishFusionMap_args & rhs) const
  {
    if (!(fusion_map == rhs.fusion_map))
      return false;
    return true;
  }
  bool operator != (const RosService_publishFusionMap_args &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const RosService_publishFusionMap_args & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};


class RosService_publishFusionMap_pargs {
 public:


  virtual ~RosService_publishFusionMap_pargs() throw();
  const Fusionmap* fusion_map;

  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _RosService_publishTrafficLightDetect_args__isset {
  _RosService_publishTrafficLightDetect_args__isset() : traffic_light_detect(false) {}
  bool traffic_light_detect :1;
} _RosService_publishTrafficLightDetect_args__isset;

class RosService_publishTrafficLightDetect_args {
 public:

  RosService_publishTrafficLightDetect_args(const RosService_publishTrafficLightDetect_args&);
  RosService_publishTrafficLightDetect_args& operator=(const RosService_publishTrafficLightDetect_args&);
  RosService_publishTrafficLightDetect_args() {
  }

  virtual ~RosService_publishTrafficLightDetect_args() throw();
  TrafficLightDetect traffic_light_detect;

  _RosService_publishTrafficLightDetect_args__isset __isset;

  void __set_traffic_light_detect(const TrafficLightDetect& val);

  bool operator == (const RosService_publishTrafficLightDetect_args & rhs) const
  {
    if (!(traffic_light_detect == rhs.traffic_light_detect))
      return false;
    return true;
  }
  bool operator != (const RosService_publishTrafficLightDetect_args &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const RosService_publishTrafficLightDetect_args & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};


class RosService_publishTrafficLightDetect_pargs {
 public:


  virtual ~RosService_publishTrafficLightDetect_pargs() throw();
  const TrafficLightDetect* traffic_light_detect;

  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _RosService_publishLocalize_args__isset {
  _RosService_publishLocalize_args__isset() : localize(false) {}
  bool localize :1;
} _RosService_publishLocalize_args__isset;

class RosService_publishLocalize_args {
 public:

  RosService_publishLocalize_args(const RosService_publishLocalize_args&);
  RosService_publishLocalize_args& operator=(const RosService_publishLocalize_args&);
  RosService_publishLocalize_args() {
  }

  virtual ~RosService_publishLocalize_args() throw();
  Localize localize;

  _RosService_publishLocalize_args__isset __isset;

  void __set_localize(const Localize& val);

  bool operator == (const RosService_publishLocalize_args & rhs) const
  {
    if (!(localize == rhs.localize))
      return false;
    return true;
  }
  bool operator != (const RosService_publishLocalize_args &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const RosService_publishLocalize_args & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};


class RosService_publishLocalize_pargs {
 public:


  virtual ~RosService_publishLocalize_pargs() throw();
  const Localize* localize;

  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

typedef struct _RosService_publishDest_args__isset {
  _RosService_publishDest_args__isset() : dest(false) {}
  bool dest :1;
} _RosService_publishDest_args__isset;

class RosService_publishDest_args {
 public:

  RosService_publishDest_args(const RosService_publishDest_args&);
  RosService_publishDest_args& operator=(const RosService_publishDest_args&);
  RosService_publishDest_args() {
  }

  virtual ~RosService_publishDest_args() throw();
  Dest dest;

  _RosService_publishDest_args__isset __isset;

  void __set_dest(const Dest& val);

  bool operator == (const RosService_publishDest_args & rhs) const
  {
    if (!(dest == rhs.dest))
      return false;
    return true;
  }
  bool operator != (const RosService_publishDest_args &rhs) const {
    return !(*this == rhs);
  }

  bool operator < (const RosService_publishDest_args & ) const;

  uint32_t read(::apache::thrift::protocol::TProtocol* iprot);
  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};


class RosService_publishDest_pargs {
 public:


  virtual ~RosService_publishDest_pargs() throw();
  const Dest* dest;

  uint32_t write(::apache::thrift::protocol::TProtocol* oprot) const;

};

class RosServiceClient : virtual public RosServiceIf {
 public:
  RosServiceClient(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> prot) {
    setProtocol(prot);
  }
  RosServiceClient(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> iprot, boost::shared_ptr< ::apache::thrift::protocol::TProtocol> oprot) {
    setProtocol(iprot,oprot);
  }
 private:
  void setProtocol(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> prot) {
  setProtocol(prot,prot);
  }
  void setProtocol(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> iprot, boost::shared_ptr< ::apache::thrift::protocol::TProtocol> oprot) {
    piprot_=iprot;
    poprot_=oprot;
    iprot_ = iprot.get();
    oprot_ = oprot.get();
  }
 public:
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> getInputProtocol() {
    return piprot_;
  }
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> getOutputProtocol() {
    return poprot_;
  }
  void getTrajectory(Trajectory& _return);
  void send_getTrajectory();
  void recv_getTrajectory(Trajectory& _return);
  void publishFusionMap(const Fusionmap& fusion_map);
  void send_publishFusionMap(const Fusionmap& fusion_map);
  void publishTrafficLightDetect(const TrafficLightDetect& traffic_light_detect);
  void send_publishTrafficLightDetect(const TrafficLightDetect& traffic_light_detect);
  void publishLocalize(const Localize& localize);
  void send_publishLocalize(const Localize& localize);
  void publishDest(const Dest& dest);
  void send_publishDest(const Dest& dest);
 protected:
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> piprot_;
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> poprot_;
  ::apache::thrift::protocol::TProtocol* iprot_;
  ::apache::thrift::protocol::TProtocol* oprot_;
};

class RosServiceProcessor : public ::apache::thrift::TDispatchProcessor {
 protected:
  boost::shared_ptr<RosServiceIf> iface_;
  virtual bool dispatchCall(::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, const std::string& fname, int32_t seqid, void* callContext);
 private:
  typedef  void (RosServiceProcessor::*ProcessFunction)(int32_t, ::apache::thrift::protocol::TProtocol*, ::apache::thrift::protocol::TProtocol*, void*);
  typedef std::map<std::string, ProcessFunction> ProcessMap;
  ProcessMap processMap_;
  void process_getTrajectory(int32_t seqid, ::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, void* callContext);
  void process_publishFusionMap(int32_t seqid, ::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, void* callContext);
  void process_publishTrafficLightDetect(int32_t seqid, ::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, void* callContext);
  void process_publishLocalize(int32_t seqid, ::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, void* callContext);
  void process_publishDest(int32_t seqid, ::apache::thrift::protocol::TProtocol* iprot, ::apache::thrift::protocol::TProtocol* oprot, void* callContext);
 public:
  RosServiceProcessor(boost::shared_ptr<RosServiceIf> iface) :
    iface_(iface) {
    processMap_["getTrajectory"] = &RosServiceProcessor::process_getTrajectory;
    processMap_["publishFusionMap"] = &RosServiceProcessor::process_publishFusionMap;
    processMap_["publishTrafficLightDetect"] = &RosServiceProcessor::process_publishTrafficLightDetect;
    processMap_["publishLocalize"] = &RosServiceProcessor::process_publishLocalize;
    processMap_["publishDest"] = &RosServiceProcessor::process_publishDest;
  }

  virtual ~RosServiceProcessor() {}
};

class RosServiceProcessorFactory : public ::apache::thrift::TProcessorFactory {
 public:
  RosServiceProcessorFactory(const ::boost::shared_ptr< RosServiceIfFactory >& handlerFactory) :
      handlerFactory_(handlerFactory) {}

  ::boost::shared_ptr< ::apache::thrift::TProcessor > getProcessor(const ::apache::thrift::TConnectionInfo& connInfo);

 protected:
  ::boost::shared_ptr< RosServiceIfFactory > handlerFactory_;
};

class RosServiceMultiface : virtual public RosServiceIf {
 public:
  RosServiceMultiface(std::vector<boost::shared_ptr<RosServiceIf> >& ifaces) : ifaces_(ifaces) {
  }
  virtual ~RosServiceMultiface() {}
 protected:
  std::vector<boost::shared_ptr<RosServiceIf> > ifaces_;
  RosServiceMultiface() {}
  void add(boost::shared_ptr<RosServiceIf> iface) {
    ifaces_.push_back(iface);
  }
 public:
  void getTrajectory(Trajectory& _return) {
    size_t sz = ifaces_.size();
    size_t i = 0;
    for (; i < (sz - 1); ++i) {
      ifaces_[i]->getTrajectory(_return);
    }
    ifaces_[i]->getTrajectory(_return);
    return;
  }

  void publishFusionMap(const Fusionmap& fusion_map) {
    size_t sz = ifaces_.size();
    size_t i = 0;
    for (; i < (sz - 1); ++i) {
      ifaces_[i]->publishFusionMap(fusion_map);
    }
    ifaces_[i]->publishFusionMap(fusion_map);
  }

  void publishTrafficLightDetect(const TrafficLightDetect& traffic_light_detect) {
    size_t sz = ifaces_.size();
    size_t i = 0;
    for (; i < (sz - 1); ++i) {
      ifaces_[i]->publishTrafficLightDetect(traffic_light_detect);
    }
    ifaces_[i]->publishTrafficLightDetect(traffic_light_detect);
  }

  void publishLocalize(const Localize& localize) {
    size_t sz = ifaces_.size();
    size_t i = 0;
    for (; i < (sz - 1); ++i) {
      ifaces_[i]->publishLocalize(localize);
    }
    ifaces_[i]->publishLocalize(localize);
  }

  void publishDest(const Dest& dest) {
    size_t sz = ifaces_.size();
    size_t i = 0;
    for (; i < (sz - 1); ++i) {
      ifaces_[i]->publishDest(dest);
    }
    ifaces_[i]->publishDest(dest);
  }

};

// The 'concurrent' client is a thread safe client that correctly handles
// out of order responses.  It is slower than the regular client, so should
// only be used when you need to share a connection among multiple threads
class RosServiceConcurrentClient : virtual public RosServiceIf {
 public:
  RosServiceConcurrentClient(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> prot) {
    setProtocol(prot);
  }
  RosServiceConcurrentClient(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> iprot, boost::shared_ptr< ::apache::thrift::protocol::TProtocol> oprot) {
    setProtocol(iprot,oprot);
  }
 private:
  void setProtocol(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> prot) {
  setProtocol(prot,prot);
  }
  void setProtocol(boost::shared_ptr< ::apache::thrift::protocol::TProtocol> iprot, boost::shared_ptr< ::apache::thrift::protocol::TProtocol> oprot) {
    piprot_=iprot;
    poprot_=oprot;
    iprot_ = iprot.get();
    oprot_ = oprot.get();
  }
 public:
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> getInputProtocol() {
    return piprot_;
  }
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> getOutputProtocol() {
    return poprot_;
  }
  void getTrajectory(Trajectory& _return);
  int32_t send_getTrajectory();
  void recv_getTrajectory(Trajectory& _return, const int32_t seqid);
  void publishFusionMap(const Fusionmap& fusion_map);
  void send_publishFusionMap(const Fusionmap& fusion_map);
  void publishTrafficLightDetect(const TrafficLightDetect& traffic_light_detect);
  void send_publishTrafficLightDetect(const TrafficLightDetect& traffic_light_detect);
  void publishLocalize(const Localize& localize);
  void send_publishLocalize(const Localize& localize);
  void publishDest(const Dest& dest);
  void send_publishDest(const Dest& dest);
 protected:
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> piprot_;
  boost::shared_ptr< ::apache::thrift::protocol::TProtocol> poprot_;
  ::apache::thrift::protocol::TProtocol* iprot_;
  ::apache::thrift::protocol::TProtocol* oprot_;
  ::apache::thrift::async::TConcurrentClientSyncInfo sync_;
};

#ifdef _WIN32
  #pragma warning( pop )
#endif

} // namespace

#endif
