package wom.view.screen.windows.beast.keeper
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileBeastKeeperWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 828;
      
      private static const WINDOW_HEIGHT:int = 622;
      
      private var _beastKeeperPanel:MobileBeastKeeperPanel;
      
      private var _helpContainer:Sprite;
      
      private var beastVisible:Boolean;
      
      private var _hintButton:MPRigidButton;
      
      public function MobileBeastKeeperWindow()
      {
         super(828,622);
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
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.beast.keeper.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _helpContainer = new Sprite();
         _helpContainer.visible = false;
         addChild(_helpContainer);
         createAndAddHelpContent();
         _beastKeeperPanel = new MobileBeastKeeperPanel();
         addChild(_beastKeeperPanel);
         beastVisible = true;
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         addChild(_hintButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastKeeperPanel,_background,41);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,_closeButton,-55,4);
      }
      
      private function createAndAddHelpContent() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc5_:MPTextField = null;
         var _loc6_:int = 0;
         var _loc4_:DisplayObject = assetRepository.getDisplayObject("MobileDarkBackground");
         _loc4_.width = 721;
         _loc4_.height = 483;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_loc4_,_background,81);
         _helpContainer.addChild(_loc4_);
         var _loc3_:DisplayObject = assetRepository.getDisplayObject("MPose5Left");
         MobileAlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc4_,-4,_loc4_.height - _loc3_.height - 2);
         _helpContainer.addChild(_loc3_);
         var _temp_2:* = _helpContainer;
         var _loc9_:String = "ui.windows.battlepoints.tips.title";
         var _loc2_:MPTextField = createDefaultCaptionTextField(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc9_),46);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_loc2_,_loc4_,-19);
         var _loc8_:DisplayObject = _loc2_;
         var _loc7_:int = _loc2_.height;
         _loc6_ = 1;
         while(_loc6_ < 7)
         {
            _loc1_ = assetRepository.getDisplayObject("SymbolTickDisable");
            MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_loc1_,_loc8_,10,_loc7_);
            if(_loc6_ == 1)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_loc1_,_loc4_,230,56);
            }
            _helpContainer.addChild(_loc1_);
            var _temp_4:* = _helpContainer;
            var _loc10_:String = "ui.windows.beast.keeper.help.tips." + _loc6_;
            _loc5_ = createDefaultTextField(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc10_),23,420);
            MobileAlignmentUtil.alignRightOf(_loc5_,_loc1_,21);
            _helpContainer.addChild(_loc5_);
            _loc8_ = _loc1_;
            _loc7_ = _loc5_.height + 15;
            _loc6_++;
         }
      }
      
      public function onHint() : void
      {
         _beastKeeperPanel.visible = !beastVisible;
         _helpContainer.visible = beastVisible;
         beastVisible = !beastVisible;
      }
      
      public function get hintButton() : MPRigidButton
      {
         return _hintButton;
      }
   }
}

