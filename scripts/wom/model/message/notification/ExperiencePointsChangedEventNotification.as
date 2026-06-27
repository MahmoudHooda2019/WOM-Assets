package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ExperiencePointsChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _experiencePoints:Number;
      
      public function ExperiencePointsChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _experiencePoints = param1.experiencePoints;
      }
      
      public function get experiencePoints() : Number
      {
         return _experiencePoints;
      }
   }
}

