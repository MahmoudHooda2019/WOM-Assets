package wom.view.screen.popups.event
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomDefaultAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileEventOngoingPanel extends MobileBaseWindowPanel implements View
   {
      
      private static const WIDTH:int = 774;
      
      private static const HEIGHT:int = 595;
      
      private var imageBackground:DisplayObject;
      
      private var eventTextField:MobileWomTextField;
      
      private var rewardsLabel:MPTextField;
      
      private var samuraiView:MobileEventRewardView;
      
      private var siegeTowerView:MobileEventRewardView;
      
      private var acidRainView:MobileEventRewardView;
      
      private var longbowmanView:MobileEventRewardView;
      
      private var cyclopView:MobileEventRewardView;
      
      private var iceshardView:MobileEventRewardView;
      
      private var acidTowerView:MobileEventRewardView;
      
      private var healAuraView:MobileEventRewardView;
      
      private var _howToPlayButton:MPButton;
      
      private var helpContainer:Sprite;
      
      private var contentContainer:Sprite;
      
      private var backgroundImageName:String;
      
      public function MobileEventOngoingPanel()
      {
         super(774,595);
      }
      
      private static function createDefaultCaptionTextField(param1:DisplayObjectContainer, param2:String, param3:int) : MPTextField
      {
         var _loc4_:MPTextField = new MobileCaptionTextField();
         _loc4_.textRendererProperties.textFormat = getCaptionTextFormat(param3);
         param1.addChild(_loc4_);
         _loc4_.text = param2;
         return _loc4_;
      }
      
      private static function createDefaultTextField(param1:DisplayObjectContainer, param2:String, param3:int, param4:int) : MPTextField
      {
         var _loc5_:MPTextField = new MobileWomTextField();
         _loc5_.width = param4;
         _loc5_.textRendererProperties.textFormat = getWomTextFormat(param3,"left",16777215);
         _loc5_.textRendererProperties.wordWrap = true;
         param1.addChild(_loc5_);
         _loc5_.text = param2;
         return _loc5_;
      }
      
      public static function createProgressBar(param1:DisplayObjectContainer) : MobileWomProgressBar
      {
         var _loc2_:MobileWomProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _loc2_.width = 237;
         _loc2_.align = "center";
         param1.addChild(_loc2_);
         return _loc2_;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         contentContainer = new Sprite();
         addChild(contentContainer);
         helpContainer = new Sprite();
         helpContainer.visible = false;
         addChild(helpContainer);
         createAndAddHelpContent();
         var _loc3_:String = MobileWomDefaultAssetRepository.fixEventAssetName(backgroundImageName);
         var _loc1_:Number = 761;
         var _loc2_:Number = 321;
         imageBackground = assetRepository.getRemoteDisplayObject(_loc3_,_loc1_,_loc2_);
         contentContainer.addChild(imageBackground);
         eventTextField = new MobileWomTextField();
         eventTextField.width = bg.width - 90;
         eventTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center",16777215);
         eventTextField.textRendererProperties.wordWrap = true;
         contentContainer.addChild(eventTextField);
         var _temp_5:* = eventTextField;
         var _loc4_:String = "ui.popups.event.main.desc";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         rewardsLabel = createCaptionTextField();
         var _temp_7:* = rewardsLabel;
         var _loc5_:String = "ui.popups.event.main.rewards";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         samuraiView = createRewardView("SamuraiTeamPortrait",300);
         acidRainView = createRewardView("AcidRainPortrait",500);
         siegeTowerView = createRewardView("SiegeTowerPortrait",800);
         longbowmanView = createRewardView("LongBowmanPortrait",900);
         cyclopView = createRewardView("CyclopPortrait",1500);
         iceshardView = createRewardView("IceShardPortrait",1750);
         acidTowerView = createRewardView("AcidTowerPortrait",2000);
         healAuraView = createRewardView("HealAuraPortrait",2500);
         _howToPlayButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _howToPlayButton.width = 199;
         addChild(_howToPlayButton);
         var _temp_17:* = _howToPlayButton;
         var _loc6_:String = "ui.popups.event.main.howtoplay";
         _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         drawLayout();
      }
      
      private function createRewardView(param1:String, param2:int) : MobileEventRewardView
      {
         var _loc3_:MobileEventRewardView = new MobileEventRewardView(assetRepository,param1,param2);
         contentContainer.addChild(_loc3_);
         _loc3_.drawLayout();
         return _loc3_;
      }
      
      private function createCaptionTextField() : MobileCaptionTextField
      {
         var _loc1_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc1_.textRendererProperties.textFormat = getCaptionTextFormat(23);
         contentContainer.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createAndAddHelpContent() : void
      {
         var _loc6_:DisplayObject = null;
         var _loc1_:DisplayObject = null;
         var _loc3_:MPTextField = null;
         var _loc4_:int = 0;
         var _loc2_:DisplayObject = assetRepository.getDisplayObject("MPose5Left");
         MobileAlignmentUtil.alignAccordingToPositionOf(_loc2_,bg,-4,bg.height - _loc2_.height - 2);
         helpContainer.addChild(_loc2_);
         var _loc5_:int = 0;
         _loc4_ = 1;
         while(_loc4_ < 7)
         {
            _loc1_ = assetRepository.getDisplayObject("SymbolTickDisable");
            if(_loc4_ == 1)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_loc1_,bg,230,56);
               _loc6_ = _loc1_;
            }
            else
            {
               MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_loc1_,_loc6_,10,_loc5_);
            }
            helpContainer.addChild(_loc1_);
            var _temp_1:* = helpContainer;
            var _loc7_:String = "ui.popups.event.main.tips." + _loc4_;
            _loc3_ = createDefaultTextField(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc7_),23,420);
            MobileAlignmentUtil.alignRightOf(_loc3_,_loc1_,21);
            helpContainer.addChild(_loc3_);
            _loc6_ = _loc1_;
            _loc5_ = _loc3_.height + 15;
            _loc4_++;
         }
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(imageBackground,bg,20);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(eventTextField,imageBackground,imageBackground.height - eventTextField.height - 20);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(rewardsLabel,imageBackground,imageBackground.height + 10);
         var _loc1_:int = 360 + longbowmanView.width;
         var _loc2_:Number = bg.width - _loc1_ >> 1;
         MobileAlignmentUtil.alignAccordingToPositionOf(samuraiView,bg,_loc2_,385);
         MobileAlignmentUtil.alignAccordingToPositionOf(acidRainView,bg,_loc2_ + 120,385);
         MobileAlignmentUtil.alignAccordingToPositionOf(siegeTowerView,bg,_loc2_ + 240,385);
         MobileAlignmentUtil.alignAccordingToPositionOf(longbowmanView,bg,_loc2_ + 360,385);
         var _loc3_:int = 114;
         MobileAlignmentUtil.alignAccordingToPositionOf(cyclopView,bg,_loc2_,385 + _loc3_);
         MobileAlignmentUtil.alignAccordingToPositionOf(iceshardView,bg,_loc2_ + 120,385 + _loc3_);
         MobileAlignmentUtil.alignAccordingToPositionOf(acidTowerView,bg,_loc2_ + 240,385 + _loc3_);
         MobileAlignmentUtil.alignAccordingToPositionOf(healAuraView,bg,_loc2_ + 360,385 + _loc3_);
         MobileAlignmentUtil.alignAccordingToPositionOf(_howToPlayButton,imageBackground,13,15);
      }
      
      public function toggleHelpContent() : void
      {
         contentContainer.visible = !contentContainer.visible;
         helpContainer.visible = !helpContainer.visible;
         var _loc1_:String;
         var _loc2_:String;
         _howToPlayButton.label = contentContainer.visible ? (_loc1_ = "ui.popups.event.main.howtoplay",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_loc2_ = "ui.popups.event.main.back",peak.i18n.PText.INSTANCE.getText0(_loc2_));
      }
      
      public function get howToPlayButton() : MPButton
      {
         return _howToPlayButton;
      }
      
      public function setBackgroundImageName(param1:String) : void
      {
         backgroundImageName = param1;
      }
   }
}

