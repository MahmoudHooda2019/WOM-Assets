package wom.model.game.inventory
{
   import peak.logging.LoggerContext;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.service.logging.WomLoggerContexts;
   
   public class PartSellPriceCalculationUtil
   {
      
      public function PartSellPriceCalculationUtil()
      {
         super();
      }
      
      public static function calculateSellPrice(param1:PartTypeDIO, param2:BuildingTypeDIO, param3:CityStatusInfo, param4:ResourceQuantityType) : ResourceAmountDTO
      {
         var _loc7_:int = 0;
         var _loc5_:BuildingInfo = null;
         var _loc6_:int = 0;
         if(param4 == ResourceQuantityType.ONE_PERCENT || param4 == ResourceQuantityType.FOUR_PERCENT)
         {
            return new ResourceAmountDTO(param1.sellingResourceType,(param3.totalResourceCapacity >> 2) * param4.percent / 100);
         }
         _loc7_ = 0;
         while(_loc7_ < param3.buildings.length)
         {
            _loc5_ = param3.buildings[_loc7_];
            if(_loc5_.buildingTypeId == 10)
            {
               _loc6_ = 0;
               if(param4 == ResourceQuantityType.BIG)
               {
                  _loc6_ = int(param2.buildingSpecificInfo[BuildingSpecificInfoType.LARGE_GIFT_AMOUNTS.id][_loc5_.level - 1]);
               }
               else
               {
                  _loc6_ = int(param2.buildingSpecificInfo[BuildingSpecificInfoType.SMALL_GIFT_AMOUNTS.id][_loc5_.level - 1]);
               }
               return new ResourceAmountDTO(param1.sellingResourceType,_loc6_);
            }
            _loc7_++;
         }
         log(LoggerContext.combine(LoggerContexts.UNEXPECTED,WomLoggerContexts.GAME),"City Center could not be found for calculating sell price of part");
         return new ResourceAmountDTO(param1.sellingResourceType,0);
      }
   }
}

