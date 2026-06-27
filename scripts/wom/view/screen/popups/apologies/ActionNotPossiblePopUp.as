package wom.view.screen.popups.apologies
{
   import fl.controls.Button;
   import peak.component.PTextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.util.GenericWindow;
   
   public class ActionNotPossiblePopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 450;
      
      private static const WINDOW_HEIGHT:int = 150;
      
      public static const CURRENTLY_RECRUITING:int = 1;
      
      public static const NOT_RECRUITABLE:int = 2;
      
      public static const NOT_ENOUGH_RESOURCES_RECRUITMENT:int = 3;
      
      public static const NEEDS_TO_BE_RECRUITED_FIRST:int = 4;
      
      public static const ACTIVE_TRAINING_FOR_THIS_BUILDING:int = 5;
      
      public static const TRAINING_PREREQUISITES_NOT_SATISFIED:int = 6;
      
      public static const NOT_ENOUGH_RESOURCES_TRAINING:int = 7;
      
      public static const JOB_CAPACITY_ALREADY_REACHED:int = 8;
      
      public static const BEAST_HEALTH_IS_NOT_FULL:int = 9;
      
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
      
      public static const NEEDS_TO_BE_UNLOCKED_FIRST:int = 104;
      
      private var _type:int;
      
      private var _message:String;
      
      private var _title:String;
      
      private var _messageField:PTextField;
      
      private var _okButton:Button;
      
      public function ActionNotPossiblePopUp(param1:int, param2:String = "", param3:String = "")
      {
         super(450,150);
         _type = param1;
         _message = param2;
         if(param3 == "")
         {
            var _loc4_:String = "ui.popups.actionnotpossible.header";
            _title = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         }
         else
         {
            _title = param3;
         }
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader(_title);
         _messageField = new WomTextField();
         _messageField.extraCharWidth = 4;
         _messageField.defaultTextFormat = WomTextFormats.CENTER_20;
         _messageField.multiline = true;
         _messageField.wordWrap = true;
         _messageField.width = 350;
         _messageField.autoSize = "center";
         addChild(_messageField);
         var _loc1_:String;
         _messageField.text = _type != -1 ? (_loc1_ = "ui.popups.actionnotpossible.type." + _type,peak.i18n.PText.INSTANCE.getText0(_loc1_)) : _message;
         _okButton = new WomBlueLargeButton();
         _okButton.width = 110;
         addChild(_okButton);
         var _temp_3:* = _okButton;
         var _loc2_:String = "ui.popups.actionnotpossible.ok";
         _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignMiddleOf(_messageField,_background);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,120);
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}

