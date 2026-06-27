package wom.controller.event.mobile
{
   import flash.events.Event;
   import wom.view.ui.tutorial.mobile.MobileDeployHandView;
   
   public class MobileCanvasDeployHandEvent extends Event
   {
      
      public static const SHOW:String = "showCanvasDeployHand";
      
      public static const HIDE:String = "hideCanvasDeployHand";
      
      private var _deployHand:MobileDeployHandView;
      
      public function MobileCanvasDeployHandEvent(param1:String, param2:MobileDeployHandView = null)
      {
         super(param1);
         _deployHand = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileCanvasDeployHandEvent(type,_deployHand);
      }
      
      public function get deployHand() : MobileDeployHandView
      {
         return _deployHand;
      }
   }
}

