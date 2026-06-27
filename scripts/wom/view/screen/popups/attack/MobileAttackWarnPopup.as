package wom.view.screen.popups.attack
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.Profile;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileAttackWarnPopup extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 660;
      
      private static const WINDOW_HEIGHT:int = 247;
      
      private var _cancelButton:MobileWomButton;
      
      private var _protection:Boolean;
      
      private var _npc:Boolean;
      
      private var _isQuickAttack:Boolean;
      
      private var _profile:Profile;
      
      private var _isTournamentAttack:Boolean;
      
      private var _isTournamentAttackByGold:Boolean;
      
      public function MobileAttackWarnPopup(param1:Boolean, param2:Profile, param3:Boolean, param4:Boolean = false, param5:* = false, param6:* = false, param7:int = 660, param8:* = 247)
      {
         super(param7,param8);
         _protection = param1;
         _profile = param2;
         _npc = param3;
         _isQuickAttack = param4;
         _isTournamentAttack = param5;
         _isTournamentAttackByGold = param6;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String;
         var _loc3_:String;
         setHeader(_protection ? (_loc2_ = "ui.windows.map.areyousure",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : (_loc3_ = "ui.popups.resourcecapacitywarning.header",peak.i18n.PText.INSTANCE.getText0(_loc3_)));
         _imageAsset = assetRepository.getDisplayObject("MPose2Left");
         addChild(_imageAsset);
         var _loc4_:String;
         var _loc5_:String;
         _speechBubble = new MobileSpeechBubbleView(394,_protection ? (_loc4_ = "ui.windows.map.attackconfirm",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : (_loc5_ = "ui.popups.resourcecapacitywarning.body",peak.i18n.PText.INSTANCE.getText0(_loc5_)),null,false,40,55,65);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _actionButton.width = 300;
         var _loc6_:String;
         var _loc7_:String;
         _actionButton.label = _protection ? (_loc6_ = "ui.windows.map.tohell",peak.i18n.PText.INSTANCE.getText0(_loc6_)) : (_loc7_ = "ui.popups.resourcecapacitywarning.nevermind",peak.i18n.PText.INSTANCE.getText0(_loc7_));
         addChild(_actionButton);
         _cancelButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _cancelButton.width = 280;
         var _loc8_:String;
         var _loc9_:String;
         _cancelButton.label = _protection ? (_loc8_ = "ui.windows.map.reconsider",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "ui.popups.resourcecapacitywarning.reconsider",peak.i18n.PText.INSTANCE.getText0(_loc9_));
         addChild(_cancelButton);
         var _loc1_:int = _speechBubble.height + 87 - _windowHeight;
         _speechBubble.speechArrowVerticalPosition += _loc1_;
         windowHeight = _windowHeight + _loc1_;
         drawBackground();
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,12,_windowHeight - 18 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,176,39);
         MobileAlignmentUtil.alignAccordingToPositionOf(_actionButton,_background,(_windowWidth - totalButtonWidth) / 2,_windowHeight - _actionButton.height / 2);
         MobileAlignmentUtil.alignRightOf(_cancelButton,_actionButton,6);
      }
      
      public function get totalButtonWidth() : int
      {
         return _actionButton.width + _cancelButton.width + 6;
      }
      
      public function get cancelButton() : MobileWomButton
      {
         return _cancelButton;
      }
      
      public function get npc() : Boolean
      {
         return _npc;
      }
      
      public function get isQuickAttack() : Boolean
      {
         return _isQuickAttack;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get attackButton() : MobileWomButton
      {
         return _actionButton;
      }
      
      public function get isTournamentAttack() : Boolean
      {
         return _isTournamentAttack;
      }
      
      public function get isTournamentAttackByGold() : Boolean
      {
         return _isTournamentAttackByGold;
      }
   }
}

