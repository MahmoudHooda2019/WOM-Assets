package wom.model.game.building
{
   public class BuildingInfoUtil
   {
      
      public function BuildingInfoUtil()
      {
         super();
      }
      
      public static function getBuildingByBuildingTypeId(param1:Vector.<BuildingInfo>, param2:int) : BuildingInfo
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.buildingTypeId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getBuildingByBuildingInstanceId(param1:Vector.<BuildingInfo>, param2:int) : BuildingInfo
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.instanceId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

