package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.CityInfoDTO;
   import wom.model.game.viral.ViralAction;
   import wom.model.message.util.ViralActionDeserializeUtil;
   
   public class StatusNotification extends AbstractIncomingMessage
   {
      
      private var _city:CityInfoDTO;
      
      private var _goldCapacityRemainingTime:Number;
      
      private var _viralActions:Vector.<ViralAction>;
      
      public function StatusNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Object = param1.cityStatus;
         _city = new CityInfoDTO();
         _city.deserialize(param1);
         _goldCapacityRemainingTime = _loc2_.goldCapacityRemainingTime;
         _viralActions = new Vector.<ViralAction>();
         for each(var _loc3_ in _loc2_.viralActions)
         {
            _viralActions.push(ViralActionDeserializeUtil.createViralAction(_loc3_));
         }
      }
      
      public function get city() : CityInfoDTO
      {
         return _city;
      }
      
      public function get goldCapacityRemainingTime() : Number
      {
         return _goldCapacityRemainingTime;
      }
      
      public function get viralActions() : Vector.<ViralAction>
      {
         return _viralActions;
      }
   }
}

