package wom.view.screen.popups
{
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.window.MobileWindowEnumerationButton;
   
   public class MobileClementineChangableActionPopUp extends MobileGenericActionPopUp
   {
      
      public static const CLEMENTINE_EMOTION_HAPPY:int = 0;
      
      public static const CLEMENTINE_EMOTION_NEUTRAL:int = 1;
      
      public static const CLEMENTINE_EMOTION_SAD2LEFT:int = 2;
      
      private var _clementineEmotion:int;
      
      public function MobileClementineChangableActionPopUp(param1:int = 0, param2:String = "", param3:String = "", param4:Vector.<MobileWindowEnumerationButton> = null, param5:int = 536, param6:int = 217)
      {
         super(param2,param3,param4,param5,param6);
         _clementineEmotion = param1;
      }
      
      override protected function getClementineAsset() : String
      {
         switch(_clementineEmotion - 1)
         {
            case 0:
               return "MPose7Right";
            case 1:
               return "MPose2Left";
            default:
               return "MPose4";
         }
      }
      
      override protected function getDescTextFieldWidth() : Number
      {
         return 330;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function drawClementineLayout() : void
      {
         switch(_clementineEmotion - 1)
         {
            case 0:
               MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,5,_windowHeight - 18 - _imageAsset.height);
               break;
            case 1:
               MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,12,_windowHeight - 18 - _imageAsset.height);
               break;
            default:
               MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-4,_windowHeight - 18 - _imageAsset.height);
         }
      }
      
      override protected function getSpeechBubbleXIndent() : int
      {
         return 176;
      }
   }
}

