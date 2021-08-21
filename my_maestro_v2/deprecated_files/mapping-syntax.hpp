#ifndef MAESTRO_MAPPING_SYNTAX_HPP_
#define MAESTRO_MAPPING_SYNTAX_HPP_

#include <string>
#include <iostream>

#include<boost/format.hpp>

//#include "program-syntax.hpp"

namespace maestro {

  enum class DirectiveClass {
    MAP,
	  TEMPORAL_MAP,
	  SPATIAL_MAP,
	  UNROLL,
	  MERGE,
	  CLUSTER,
	  INVALID
  };

  enum class ClusterClass {
    LOGICAL,
    PHYSICAL
  };

  const std::string tkn_temporal_map = "Temporal_Map";
  const std::string tkn_spatial_map = "Spatial_Map";
  const std::string tkn_unroll = "Unroll";
  const std::string tkn_tile = "Cluster";
  const std::string tkn_delimiters = " ,->()";
  const std::string default_loop_var = "zz";

  class Directive {
    protected:
      std::string target_loop_variable_name_;
      DirectiveClass directive_class_;
    public:
      Directive() :
        directive_class_(DirectiveClass::INVALID),
        target_loop_variable_name_("")
      {
      }

      Directive(DirectiveClass cls) :
        directive_class_(cls),
        target_loop_variable_name_("")
      {
      }

      Directive(DirectiveClass cls, std::string var_nm) :
        directive_class_(cls),
        target_loop_variable_name_(var_nm)
      {
      }

      std::string GetVarName() {
        return target_loop_variable_name_;
      }

      virtual ~Directive() {}

      virtual std::string ToString() {
        return "Invalid directive";
      }

      virtual DirectiveClass GetClass() {
        return DirectiveClass::INVALID;
      }

      virtual int GetSize() {
          return 1;
      }

      virtual int GetOffset(){
          return 1;
      }
  }; // End of class Directive

  class Map : public Directive {
    protected:
      int map_size_;
      int offset_;
    public:
      Map(int mapSz, int ofs, std::string var_nm) :
        Directive(DirectiveClass::MAP, var_nm),
        map_size_(mapSz),
        offset_(ofs)
      {
      }
      virtual ~Map() {}

      virtual std::string ToString() {
        return "Invalid directive";
      }

      virtual DirectiveClass GetClass() {
        return DirectiveClass::INVALID;
      }

      virtual int GetSize() {
        return map_size_;
      }
      virtual int GetOffset() {
        return offset_;
      }
  }; // End of class Map

  class TemporalMap : public Map {
    public:
      TemporalMap(std::string var_nm, int mapSz, int ofs) :
        Map(mapSz, ofs, var_nm)
      {
      }

      virtual ~TemporalMap() {}

      virtual std::string ToString() {
        std::string ret = boost::str(boost::format("Temporal Map(%s), map_size: %d, offset: %d")
                                        % target_loop_variable_name_
                                        % map_size_
                                        % offset_ );
        return ret;
      }

      virtual DirectiveClass GetClass() {
        return DirectiveClass::TEMPORAL_MAP;
      }

      virtual int GetSize() {
        return map_size_;
      }
      virtual int GetOffset() {
        return offset_;
      }
  }; // End of class TemporalMap

  class SpatialMap : public Map {
    protected:
      int num_spatial_components_;
    public:
      SpatialMap(std::string var_nm, int mapSz, int ofs) :
        Map(mapSz, ofs, var_nm),
        num_spatial_components_(1)
      {
      }

      SpatialMap(std::string var_nm, int mapSz, int ofs, int num_components) :
        Map(mapSz, ofs, var_nm),
        num_spatial_components_(num_components)
      {
      }

      void SetNumSpatialComponents(int num_comp) {
        num_spatial_components_ = num_comp;
      }

      virtual ~SpatialMap() {}

      virtual std::string ToString() {
        std::string ret = boost::str(boost::format("Spatial Map(%s), map_size: %d, offset: %d, spatial_components: %d")
                                        % target_loop_variable_name_
                                        % map_size_
                                        % offset_
                                        % num_spatial_components_);
        return ret;
      }

      virtual DirectiveClass GetClass() {
        return DirectiveClass::SPATIAL_MAP;
      }

      virtual int GetSize() {
        return map_size_;
      }
      virtual int GetOffset() {
        return offset_;
      }
  }; // End of class SpatialMap

  class Unroll : public Directive {
    protected:

    public:
      Unroll(std::string var_nm) :
        Directive(DirectiveClass::UNROLL, var_nm)
      {
      }

      virtual std::string ToString() {
        std::string ret = boost::str(boost::format("Unroll(%s)")
                                        % target_loop_variable_name_);
        return ret;
      }

      virtual DirectiveClass GetClass() {
        return DirectiveClass::UNROLL;
      }

  }; // End of class Unroll

  class Cluster : public Directive {
    protected:
      ClusterClass cluster_class_;
      int cluster_size_;

    public:
      Cluster(std::string var_nm, int tile_sz, ClusterClass cluster_class) :
        Directive(DirectiveClass::CLUSTER, var_nm),
        cluster_size_(tile_sz),
        cluster_class_(cluster_class)
      {
      }

      Cluster(std::string var_nm, int tile_sz) :
        Directive(DirectiveClass::CLUSTER, var_nm),
        cluster_size_(tile_sz),
        cluster_class_(ClusterClass::LOGICAL)
      {
      }


      virtual std::string ToString() {
        std::string ret = boost::str(boost::format("Cluster(%s), cluster_size: %d")
                                        % target_loop_variable_name_
                                        % cluster_size_);
        return ret;
      }

      virtual DirectiveClass GetClass() {
        return DirectiveClass::CLUSTER;
      }

      virtual int GetSize() {
          return cluster_size_;
      }

  }; // End of class Tile

}; // End of namespace maestro


#endif
