package peak.util
{
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   
   public class ExternalMouseHandler
   {
      
      private static var _init:Boolean = false;
      
      private static var _currItem:InteractiveObject;
      
      private static var _clonedEvent:MouseEvent;
      
      public function ExternalMouseHandler()
      {
         super();
      }
      
      public static function init(param1:Stage) : void
      {
         if(!_init)
         {
            _init = true;
            param1.addEventListener("mouseMove",onMouseMove,false,0,true);
            if(ExternalInterface.available)
            {
               ExternalInterface.call("onFlashMouseWheel");
               ExternalInterface.addCallback("onJSMouseWheel",_onJSMouseWheel);
               ExternalInterface.addCallback("onJSMouseLeave",_onJSMouseLeave);
            }
         }
      }
      
      private static function onMouseMove(param1:MouseEvent) : void
      {
         _currItem = InteractiveObject(param1.target);
         _clonedEvent = MouseEvent(param1);
      }
      
      private static function _onJSMouseWheel(param1:Number) : void
      {
         ExternalInterface.call("console.log","onJSMouseWheel called");
         if(_currItem && _clonedEvent)
         {
            ExternalInterface.call("console.log","onJSMouseWheel dispatch success");
            _currItem.dispatchEvent(new MouseEvent("mouseWheel",true,false,_clonedEvent.localX,_clonedEvent.localY,_clonedEvent.relatedObject,_clonedEvent.ctrlKey,_clonedEvent.altKey,_clonedEvent.shiftKey,_clonedEvent.buttonDown,int(param1)));
         }
      }
      
      private static function _onJSMouseLeave() : void
      {
         if(_currItem && _clonedEvent)
         {
            _currItem.dispatchEvent(new MouseEvent("mouseUp"));
         }
      }
   }
}

