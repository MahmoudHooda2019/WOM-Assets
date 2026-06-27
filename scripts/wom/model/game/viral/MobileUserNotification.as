package wom.model.game.viral
{
   import starling.display.DisplayObject;
   
   public class MobileUserNotification extends UserNotification
   {
      
      private var _displayObject:DisplayObject;
      
      public function MobileUserNotification(param1:int, param2:int, param3:String, param4:String, param5:DisplayObject, param6:Boolean = false)
      {
         super(param1,param2,param3,param4,param6);
         _displayObject = param5;
      }
      
      public function get displayObject() : DisplayObject
      {
         return _displayObject;
      }
   }
}

