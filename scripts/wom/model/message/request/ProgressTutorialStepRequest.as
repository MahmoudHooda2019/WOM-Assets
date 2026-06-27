package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ProgressTutorialStepRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public static const STATE_ACTIVATED:int = 1;
      
      public static const STATE_COMPLETED:int = 2;
      
      private var _stepId:String;
      
      private var _state:int;
      
      private var _questNo:Object;
      
      private var _tutorialName:String;
      
      public function ProgressTutorialStepRequest(param1:String, param2:int, param3:Object = null, param4:String = null)
      {
         super();
         _stepId = param1;
         _state = param2;
         _questNo = param3;
         _tutorialName = param4;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {
            "stepId":_stepId,
            "state":_state
         };
         if(_questNo != null)
         {
            _loc1_.questNo = _questNo;
         }
         if(_tutorialName != null)
         {
            _loc1_.tutorialName = _tutorialName;
         }
         return _loc1_;
      }
   }
}

