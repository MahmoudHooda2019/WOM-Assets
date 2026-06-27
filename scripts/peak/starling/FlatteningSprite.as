package peak.starling
{
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class FlatteningSprite extends Sprite
   {
      
      public function FlatteningSprite()
      {
         super();
         addEventListener("touch",onTouch);
      }
      
      protected function onTouch(param1:TouchEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            _loc3_ = _loc2_.phase;
            if(_loc3_ == "began")
            {
               flatten();
            }
            else if(_loc3_ == "ended" && stage)
            {
               flatten();
            }
         }
      }
   }
}

