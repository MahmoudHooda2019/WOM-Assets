package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.component.enum.ActionType;
   
   public class DecorationTooltipEvent extends Event
   {
      
      public static const SHOW:String = "showDecorationTooltip";
      
      public static const CLOSE:String = "closeDecorationTooltip";
      
      private var _actionType:ActionType;
      
      private var _decoration:Decoration;
      
      private var _help:Boolean;
      
      public function DecorationTooltipEvent(param1:String, param2:ActionType = null, param3:Decoration = null, param4:Boolean = false)
      {
         super(param1);
         _actionType = param2;
         _decoration = param3;
         _help = param4;
      }
      
      public function get decoration() : Decoration
      {
         return _decoration;
      }
      
      public function get actionType() : ActionType
      {
         return _actionType;
      }
      
      public function get help() : Boolean
      {
         return _help;
      }
   }
}

