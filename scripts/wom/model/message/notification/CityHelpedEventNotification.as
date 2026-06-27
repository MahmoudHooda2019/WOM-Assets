package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.help.HelpInfo;
   
   public class CityHelpedEventNotification extends AbstractIncomingMessage
   {
      
      private var _helpInfo:HelpInfo = null;
      
      public function CityHelpedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         if("helpDetails" in param1)
         {
            _helpInfo = HelpInfo.createHelpInfo(param1.helpDetails);
         }
      }
      
      public function get helpInfo() : HelpInfo
      {
         return _helpInfo;
      }
   }
}

