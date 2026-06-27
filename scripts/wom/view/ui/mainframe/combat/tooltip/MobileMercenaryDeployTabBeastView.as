package wom.view.ui.mainframe.combat.tooltip
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileMercenaryButtonView;
   
   public class MobileMercenaryDeployTabBeastView extends MobileMercenaryButtonView
   {
      
      public static const DEPLOY:int = 1;
      
      public static const HOLD:int = 2;
      
      public static const RETREAT:int = 3;
      
      public static const RETREATED:int = 4;
      
      public static const DEAD:int = 5;
      
      public static var buttonState:int;
      
      private var shieldIcon:DisplayObject;
      
      private var levelTextField:MobileCaptionTextField;
      
      private var _beastInfo:BeastInfo;
      
      private var _beastTypeDIO:BeastTypeDIO;
      
      private var _selectByTouch:Boolean;
      
      public function MobileMercenaryDeployTabBeastView(param1:BeastInfo, param2:BeastTypeDIO)
      {
         super(null);
         _beastInfo = param1;
         _beastTypeDIO = param2;
         _selectByTouch = true;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _mercButton.isToggle = true;
         _mercButton.isSelected = false;
         shieldIcon = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         shieldIcon.width *= 37 / shieldIcon.width;
         shieldIcon.height *= 37 / shieldIcon.height;
         addChild(shieldIcon);
         levelTextField = new MobileCaptionTextField();
         levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         addChild(levelTextField);
         levelTextField.text = "" + beastInfo.level;
         updateButtonLabel();
      }
      
      override protected function initMercPortrait() : void
      {
         _mercenaryPortrait = assetRepository.getDisplayObject(_beastTypeDIO.assetName + "Portrait" + _beastInfo.level);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleOf(levelTextField,shieldIcon);
      }
      
      public function updateButtonLabel() : void
      {
         _selectionStatusTextField.visible = true;
         switch(buttonState - 1)
         {
            case 1:
               var _loc3_:String = "ui.mainframe.combat.beasttooltip.hold";
               selectionStatusText = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case 2:
               var _loc4_:String = "ui.mainframe.combat.beasttooltip.retreat";
               selectionStatusText = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case 3:
               _mercButton.isEnabled = false;
               var _loc2_:String = "ui.mainframe.combat.beasttooltip.retreated";
               selectionStatusText = peak.i18n.PText.INSTANCE.getText0(_loc2_);
               _mercenaryPortrait.alpha = 0.5;
               break;
            case 4:
               _mercButton.isEnabled = false;
               var _loc1_:String = "ui.mainframe.combat.beasttooltip.dead";
               selectionStatusText = peak.i18n.PText.INSTANCE.getText0(_loc1_);
               _mercenaryPortrait.alpha = 0.5;
               break;
            default:
               _selectionStatusTextField.visible = false;
               _selectByTouch = false;
               _mercButton.isSelected = false;
               _selectByTouch = true;
         }
      }
      
      public function switchButtonState(param1:int) : void
      {
         buttonState = param1;
         updateButtonLabel();
      }
      
      public function updateFilters() : void
      {
      }
      
      public function get beastInfo() : BeastInfo
      {
         return _beastInfo;
      }
      
      public function get beastTypeDIO() : BeastTypeDIO
      {
         return _beastTypeDIO;
      }
      
      public function get selectByTouch() : Boolean
      {
         return _selectByTouch;
      }
      
      public function set selectByTouch(param1:Boolean) : void
      {
         _selectByTouch = param1;
      }
   }
}

