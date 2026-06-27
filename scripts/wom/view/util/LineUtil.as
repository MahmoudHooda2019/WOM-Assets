package wom.view.util
{
   import flash.display.Sprite;
   
   public class LineUtil
   {
      
      public function LineUtil()
      {
         super();
      }
      
      public static function drawHorizontalSeparatorLine(param1:Sprite, param2:int, param3:int, param4:Object = null, param5:Object = null, param6:Object = null, param7:Object = null, param8:Object = null) : void
      {
         if(param4 == null)
         {
            param4 = 9338707;
         }
         if(param5 == null)
         {
            param5 = 14073981;
         }
         if(param6 == null)
         {
            param6 = 0;
         }
         if(param7 == null)
         {
            param7 = 1;
         }
         if(param8 == null)
         {
            param8 = 1;
         }
         param1.graphics.lineStyle(0,int(param4),Number(param7));
         param1.graphics.moveTo(param2,int(param6));
         param1.graphics.lineTo(param3,int(param6));
         param1.graphics.lineStyle(0,int(param5),Number(param8));
         param1.graphics.moveTo(param2,int(param6) + 1);
         param1.graphics.lineTo(param3,int(param6) + 1);
      }
      
      public static function drawVerticalSeparatorLine(param1:Sprite, param2:int, param3:int, param4:Object = null, param5:Object = null, param6:Object = null) : void
      {
         if(param4 == null)
         {
            param4 = 9338707;
         }
         if(param5 == null)
         {
            param5 = 14073981;
         }
         if(param6 == null)
         {
            param6 = 0;
         }
         param1.graphics.lineStyle(0,int(param4),1);
         param1.graphics.moveTo(int(param6),param2);
         param1.graphics.lineTo(int(param6),param3);
         param1.graphics.lineStyle(0,int(param5),1);
         param1.graphics.moveTo(int(param6) + 1,param2);
         param1.graphics.lineTo(int(param6) + 1,param3);
      }
   }
}

