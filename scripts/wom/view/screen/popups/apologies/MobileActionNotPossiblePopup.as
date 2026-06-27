package wom.view.screen.popups.apologies
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileActionNotPossiblePopup extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 653;
      
      private static const WINDOW_HEIGHT:int = 245;
      
      public static const CURRENTLY_RECRUITING:int = 1;
      
      public static const NOT_RECRUITABLE:int = 2;
      
      public static const NOT_ENOUGH_RESOURCES_RECRUITMENT:int = 3;
      
      public static const NEEDS_TO_BE_RECRUITED_FIRST:int = 4;
      
      public static const ACTIVE_TRAINING_FOR_THIS_BUILDING:int = 5;
      
      public static const TRAINING_PREREQUISITES_NOT_SATISFIED:int = 6;
      
      public static const NOT_ENOUGH_RESOURCES_TRAINING:int = 7;
      
      public static const JOB_CAPACITY_ALREADY_REACHED:int = 8;
      
      public static const BEAST_HEALTH_IS_NOT_FULL:int = 9;
      
      public static const CHAMBER_LEVEL_NOT_ENOUGH:int = 100;
      
      public static const NO_SUCH_BUILDING:int = 99;
      
      public static const BUILDING_NOT_IDLE_HIRING:int = 98;
      
      public static const BUILDING_NOT_IDLE_CENTRAL_HIRING:int = 97;
      
      public static const BEAST_IS_NOT_ACTIVE:int = 96;
      
      public static const BEAST_PRE_TRAINING_TIME_NOT_COMPLETED:int = 95;
      
      public static const BEAST_IS_ALREADY_HEALTHY:int = 94;
      
      public static const INSUFFICIENT_UNITS_TO_TRAIN_BEAST:int = 93;
      
      public static const NEEDS_ANCIENT_TELESCOPE_TO_WAR:int = 92;
      
      public static const BUILDING_NOT_IDLE_BEAST_CAVE:int = 91;
      
      public static const NO_BEAST_CAVE_BUILDING:int = 90;
      
      public static const NO_HEALTHY_BEAST_CAVE_BUILDING:int = 89;
      
      public static const BARRACK_CANNOT_BE_REMOVED:int = 88;
      
      public static const GIFT_DAILY_LIMIT:int = 87;
      
      public static const ON_GOING_RECRUITMENT:int = 86;
      
      public static const ON_GOING_TRAINING:int = 85;
      
      public static const NO_MERCS_SELECTED_TO_EXECUTE:int = 84;
      
      public static const NOT_ENOUGH_SPACE_FOR_QUEUED_MERCS:int = 83;
      
      public static const FORTIFICATION_FEATURE_NOT_AVAILABLE:int = 82;
      
      public static const DAMAGED_BUILDING_ACTIVATION_ATTEMPT:int = 81;
      
      public static const ALREADY_FAN:int = 80;
      
      public static const RESOURCE_CAPACITY_FULL:int = 79;
      
      public static const NOT_ENOUGH_SPACE_FOR_BUYING_MERC:int = 78;
      
      public static const NO_HOUSE_OF_BROTHERHOOD:int = 77;
      
      public static const NOT_ENOUGH_SPACE_FOR_GIFTED_MERCS:int = 101;
      
      public static const BEAST_KEEPER_NOT_CONSTRUCTED:int = 102;
      
      public static const BEAST_KEEPER_NOT_EXISTS:int = 103;
      
      public static const NEEDS_TO_BE_UNLOCKED_FIRST:int = 104;
      
      public static const CONTACT_SUPPORT_INPUT_EMPTY:int = 200;
      
      public static const WALL_POST_LIMIT_REACHED:int = 201;
      
      public static const CLEMENTINE_EMOTION_SAD2LEFT:int = 0;
      
      private var _clementineEmotion:int;
      
      private var _type:int;
      
      private var _title:String;
      
      private var _message:String;
      
      public function MobileActionNotPossiblePopup(param1:int, param2:int = 0, param3:String = "", param4:String = "", param5:int = 653, param6:int = 245)
      {
         super(param5,param6);
         _type = param1;
         if(param3 == "")
         {
            if(param1 == 200 || param1 == 1 || param1 == 100 || param1 == 201)
            {
               var _loc7_:String = "m.ui.popups.actionnotpossible.type." + _type;
               _message = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            }
            else
            {
               var _loc8_:String = "ui.popups.actionnotpossible.type." + _type;
               _message = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            }
         }
         else
         {
            _message = param3;
         }
         if(param4 == "")
         {
            var _loc9_:String = "ui.popups.actionnotpossible.header";
            _title = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         }
         else
         {
            _title = param4;
         }
         _clementineEmotion = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.actionnotpossible.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject(clementineAsset());
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         _speechBubble = new MobileSpeechBubbleView(438,_message,null,false,28,38,65);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 180;
         var _temp_5:* = _actionButton;
         var _loc2_:String = "ui.popups.actionnotpossible.ok";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         alignClementine();
         MobileAlignmentUtil.alignMiddleYAxisOf(_speechBubble.speechBubbleArrow,_speechBubble);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_speechBubble,_background,177);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2);
      }
      
      private function alignClementine() : void
      {
         switch(_clementineEmotion)
         {
            case 0:
               MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,0,-25);
         }
      }
      
      private function clementineAsset() : String
      {
         switch(_clementineEmotion)
         {
            case 0:
               return "MPose2Left";
            default:
               return "MPose2Left";
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}

