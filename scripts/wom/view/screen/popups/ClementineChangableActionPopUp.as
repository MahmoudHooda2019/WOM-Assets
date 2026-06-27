package wom.view.screen.popups
{
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumerationButton;
   
   public class ClementineChangableActionPopUp extends GenericActionPopUp
   {
      
      public static const CLEMENTINE_EMOTION_HAPPY:int = 0;
      
      public static const CLEMENTINE_EMOTION_NEUTRAL:int = 1;
      
      public static const CLEMENTINE_EMOTION_SAD:int = 2;
      
      private var _clementineEmotion:int;
      
      public function ClementineChangableActionPopUp(param1:int = 0, param2:String = "", param3:String = "", param4:Vector.<WindowEnumerationButton> = null, param5:int = 562, param6:int = 145)
      {
         super(param2,param3,param4,param5,param6);
         _clementineEmotion = param1;
      }
      
      override protected function getClementineAsset() : String
      {
         switch(_clementineEmotion - 1)
         {
            case 0:
               return "PoseSmall5";
            case 1:
               return "PoseSmall2";
            default:
               return "PoseSmall3";
         }
      }
      
      override protected function getDescTextFieldWidth() : Number
      {
         return 300;
      }
      
      override protected function drawClementineLayout() : void
      {
         switch(_clementineEmotion - 1)
         {
            case 0:
               AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,21,-74);
               break;
            case 1:
               AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,8,-74);
               break;
            default:
               AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,-25,-75);
         }
      }
   }
}

