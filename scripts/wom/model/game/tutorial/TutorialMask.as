package wom.model.game.tutorial
{
   public class TutorialMask
   {
      
      public static const NON_VISIBLE:TutorialMask = new TutorialMask(false);
      
      public static const VISIBLE:TutorialMask = new TutorialMask(true,0.5,1);
      
      public static const BARELY_VISIBLE:TutorialMask = new TutorialMask(true,0.01,0.01);
      
      private var _enabled:Boolean;
      
      private var _alpha:Number;
      
      private var _imageAlpha:Number;
      
      public function TutorialMask(param1:Boolean = false, param2:Number = 0, param3:Number = 0)
      {
         super();
         _enabled = param1;
         _alpha = param2;
         _imageAlpha = param3;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function get imageAlpha() : Number
      {
         return _imageAlpha;
      }
   }
}

