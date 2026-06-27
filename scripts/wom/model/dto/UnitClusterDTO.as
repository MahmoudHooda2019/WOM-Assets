package wom.model.dto
{
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class UnitClusterDTO
   {
      
      private var _unitTypeId:int;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var _units:Vector.<UnitInfo>;
      
      public function UnitClusterDTO(param1:int, param2:UnitTypeInfo, param3:Vector.<UnitInfo>)
      {
         super();
         _unitTypeId = param1;
         _unitTypeInfo = param2;
         _units = param3;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
      
      public function get units() : Vector.<UnitInfo>
      {
         return _units;
      }
   }
}

