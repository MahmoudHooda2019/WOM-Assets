package wom.view.util
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PopperBackgroundUtil
   {
      
      private static const POPPER_WIDTH:int = 1224;
      
      private static const POPPER_HEIGHT:int = 1218;
      
      public function PopperBackgroundUtil()
      {
         super();
      }
      
      public static function createPopper(param1:Sprite, param2:DisplayObject, param3:int, param4:int, param5:int, param6:int, param7:int = -1, param8:int = -1, param9:int = 18) : DisplayObject
      {
         if(param7 == -1)
         {
            param7 = 1224 - param5 >> 1;
         }
         if(param8 == -1)
         {
            param8 = 1218 - param6 >> 1;
         }
         var _loc10_:Sprite = new Sprite();
         _loc10_.graphics.beginFill(0,0);
         _loc10_.graphics.drawRoundRect(param3,param4,param5,param6,param9,param9);
         param1.addChild(_loc10_);
         param2.mask = _loc10_;
         param2.x = param3 - param7;
         param2.y = param4 - param8;
         param1.addChild(param2);
         return param2;
      }
   }
}

