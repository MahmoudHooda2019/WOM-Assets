package wom.view.screen.popups.topoff
{
   import peak.messaging.OutgoingMessage;
   import wom.model.game.window.WindowEnumeration;
   
   public class MobileDefaultTopOffResourcesPopUp extends MobileBaseTopOffResourcesPopUp
   {
      
      private var _outgoingMessage:OutgoingMessage;
      
      public function MobileDefaultTopOffResourcesPopUp(param1:String, param2:Array = null, param3:OutgoingMessage = null, param4:Vector.<WindowEnumeration> = null)
      {
         super(param1,param2,param4);
         _outgoingMessage = param3;
      }
      
      public function get outgoingMessage() : OutgoingMessage
      {
         return _outgoingMessage;
      }
   }
}

