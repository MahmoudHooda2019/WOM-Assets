package wom.view.mediator.screen.windows.hiringquarters
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class QueuedMercenaryCancelIcon extends Sprite
   {
      
      private var _icon:DisplayObject;
      
      private var _slotIndex:int;
      
      public function QueuedMercenaryCancelIcon(param1:DisplayObject, param2:int)
      {
         super();
         _icon = param1;
         _slotIndex = param2;
         addChild(_icon);
         visible = false;
      }
      
      public function get slotIndex() : int
      {
         return _slotIndex;
      }
   }
}

