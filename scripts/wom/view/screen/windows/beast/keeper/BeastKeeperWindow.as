package wom.view.screen.windows.beast.keeper
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.rigid.QuestHintButton;
   import wom.view.util.GenericWindow;
   
   public class BeastKeeperWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 734;
      
      private static const WINDOW_HEIGHT:int = 521;
      
      private var _beastKeeperPanel:BeastKeeperPanel;
      
      private var _helpButton:Button;
      
      private var _helpContainer:Sprite;
      
      public function BeastKeeperWindow()
      {
         super(734,521);
      }
      
      private static function createDefaultCaptionTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:GlowFilter = null) : TextField
      {
         var _loc5_:TextField = new CaptionTextField(param4 == null ? WomTextFormats.BLACK_FILTER : param4);
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.text = param2;
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      private static function createDefaultTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:Object = null) : TextField
      {
         var _loc5_:TextField = new WomTextField();
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.width = param4 == null ? 450 : param4 as int;
         _loc5_.multiline = true;
         _loc5_.wordWrap = true;
         _loc5_.text = param2;
         param1.addChild(_loc5_);
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
         _beastKeeperPanel = new BeastKeeperPanel();
         addChild(_beastKeeperPanel);
         _helpButton = new QuestHintButton();
         addChild(_helpButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_beastKeeperPanel,_background,32,43);
         AlignmentUtil.alignLeftOf(_helpButton,_closeButton,3);
      }
      
      private function createAndAddHelpContent() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc5_:TextField = null;
         var _loc6_:int = 0;
         var _loc4_:DisplayObject = assetRepository.getDisplayObject("BackgroundDark");
         _loc4_.width = 669;
         _loc4_.height = 458;
         AlignmentUtil.alignAccordingToPositionOf(_loc4_,_background,32,32);
         _helpContainer.addChild(_loc4_);
         var _loc3_:DisplayObject = assetRepository.getDisplayObject("PoseMedium4");
         AlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc4_,10,12);
         _helpContainer.addChild(_loc3_);
         var _temp_2:* = _helpContainer;
         var _loc9_:String = "ui.windows.beast.keeper.help.title";
         var _loc2_:TextField = createDefaultCaptionTextField(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc9_),WomTextFormats.FONT_SIZE_22);
         AlignmentUtil.alignAccordingToPositionOf(_loc2_,_loc4_,200,85);
         var _loc8_:DisplayObject = _loc2_;
         var _loc7_:int = _loc2_.height;
         _loc6_ = 1;
         while(_loc6_ < 7)
         {
            _loc1_ = assetRepository.getDisplayObject("MainQuestPreviewComplete");
            AlignmentUtil.alignHeightSpecifiedBelowOf(_loc1_,_loc8_,10,_loc7_);
            if(_loc6_ == 1)
            {
               _loc1_.x += 25;
               _loc1_.y += 5;
            }
            _helpContainer.addChild(_loc1_);
            var _temp_6:* = _helpContainer;
            var _loc10_:String = "ui.windows.beast.keeper.help.tips." + _loc6_;
            _loc5_ = createDefaultTextField(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc10_),WomTextFormats.FONT_SIZE_18,405);
            AlignmentUtil.alignRightOf(_loc5_,_loc1_,3);
            _helpContainer.addChild(_loc5_);
            _loc8_ = _loc1_;
            _loc7_ = _loc5_.height;
            _loc6_++;
         }
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         _helpContainer.visible = param1;
         _beastKeeperPanel.visible = !param1;
      }
      
      public function get helpButton() : Button
      {
         return _helpButton;
      }
   }
}

