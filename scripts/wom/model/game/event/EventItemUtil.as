package wom.model.game.event
{
   import org.robotlegs.mvcs.Actor;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class EventItemUtil extends Actor
   {
      
      public function EventItemUtil()
      {
         super();
      }
      
      public static function isUnlocked(param1:UnitTypeDIO, param2:UnitTypeInfo, param3:Vector.<int>, param4:Vector.<EventItemDIO>) : Boolean
      {
         if(!param1.event)
         {
            return param2.recruited;
         }
         var _loc5_:EventItemDIO = getEventItemDIO(param1,param4);
         if(!_loc5_)
         {
            return false;
         }
         if(!param3)
         {
            return false;
         }
         for each(var _loc6_ in param3)
         {
            if(_loc6_ == _loc5_.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getEventItemDIO(param1:UnitTypeDIO, param2:Vector.<EventItemDIO>) : EventItemDIO
      {
         if(param1)
         {
            for each(var _loc3_ in param2)
            {
               if(_loc3_.itemType == EventItemType.MERCENARY.id && _loc3_.relatedId == param1.id)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
   }
}

