package wom.controller.event.mobile
{
   import flash.events.Event;
   import wom.view.ui.MobileCanvasOptionsPanel;
   
   public class MobileCanvasOptionsPanelEvent extends Event
   {
      
      public static const SHOW:String = "showBuilidingOptionsPanel";
      
      public static const CLOSE:String = "closeBuilidingOptionsPanel";
      
      private var _panel:MobileCanvasOptionsPanel;
      
      public function MobileCanvasOptionsPanelEvent(param1:String, param2:MobileCanvasOptionsPanel = null)
      {
         super(param1);
         _panel = param2;
      }
      
      public function get panel() : MobileCanvasOptionsPanel
      {
         return _panel;
      }
      
      override public function clone() : Event
      {
         return new MobileCanvasOptionsPanelEvent(type,panel);
      }
   }
}

