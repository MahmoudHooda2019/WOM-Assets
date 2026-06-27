package peak.util
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class BitmapUtil
   {
      
      public function BitmapUtil()
      {
         super();
      }
      
      public static function flipBitmapData(param1:BitmapData, param2:String) : BitmapData
      {
         var _loc3_:Matrix = param2 == "Y" ? new Matrix(-1,0,0,1,param1.width,0) : new Matrix(1,0,0,-1,0,param1.height);
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,true,16777215);
         _loc4_.draw(param1,_loc3_,null,null,null,true);
         return _loc4_;
      }
      
      public static function mirrorBitmapData(param1:BitmapData, param2:String) : BitmapData
      {
         var _loc4_:BitmapData = flipBitmapData(param1,param2);
         var _loc3_:BitmapData = new BitmapData(param2 == "Y" ? param1.width + _loc4_.width : param1.width,param2 == "X" ? param1.height + _loc4_.height : param1.height,true,16777215);
         _loc3_.copyPixels(param1,param1.rect,new Point(0,0));
         _loc3_.copyPixels(_loc4_,_loc4_.rect,new Point(param2 == "Y" ? param1.width : 0,param2 == "X" ? param1.height : 0));
         return _loc3_;
      }
      
      public static function resizeBitmapData(param1:BitmapData, param2:int, param3:int) : BitmapData
      {
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(param2 / param1.width,param3 / param1.height);
         var _loc4_:BitmapData = new BitmapData(param2,param3,true,16777215);
         _loc4_.draw(param1,_loc5_,null,null,null,true);
         return _loc4_;
      }
   }
}

