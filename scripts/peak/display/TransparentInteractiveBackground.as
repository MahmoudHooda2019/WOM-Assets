package peak.display
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   public class TransparentInteractiveBackground extends Sprite
   {
      
      public function TransparentInteractiveBackground(param1:Number = 10, param2:Number = 10)
      {
         super();
         resize(param1,param2);
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         var _loc3_:Graphics = graphics;
         _loc3_.beginFill(0,0);
         _loc3_.drawRect(0,0,param1,param2);
         _loc3_.endFill();
         this.hitArea = this;
      }
   }
}

