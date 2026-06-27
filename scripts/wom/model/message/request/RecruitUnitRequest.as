package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class RecruitUnitRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _unitTypeId:int;
      
      private var _byGold:Boolean;
      
      private var _completeResources:Boolean;
      
      public function RecruitUnitRequest(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         super();
         _unitTypeId = param1;
         _byGold = param2;
         _completeResources = param3;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {"unitTypeId":_unitTypeId};
         if(_byGold)
         {
            _loc1_.byGold = _byGold;
         }
         else if(_completeResources)
         {
            _loc1_.completeResources = _completeResources;
         }
         return _loc1_;
      }
   }
}

