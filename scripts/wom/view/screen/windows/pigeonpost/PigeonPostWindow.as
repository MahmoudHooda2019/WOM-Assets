package wom.view.screen.windows.pigeonpost
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.viral.Subscription;
   import wom.view.component.WomCustomCursorAwareTextField;
   import wom.view.component.WomPigeonPostCheckBox;
   import wom.view.component.WomScrollPane;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.rigid.QuestHintButton;
   import wom.view.util.GenericWindow;
   
   public class PigeonPostWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 528;
      
      private static const WINDOW_HEIGHT:int = 404;
      
      private static const BACKGROUND_WIDTH:int = 332;
      
      private static const BACKGROUND_HEIGHT:int = 202;
      
      private var _gentleHealerAsset:AssetDisplayObject;
      
      private var headerTextField:TextField;
      
      private var checkBoxesBackground:DisplayObject;
      
      private var helpBackground:DisplayObject;
      
      private var _hintButton:QuestHintButton;
      
      private var _helpTextField:TextField;
      
      private var descTextField:TextField;
      
      private var _saveCloseButton:WomButton;
      
      private var _scrollPane:WomScrollPane;
      
      private var _scrollPaneContent:Sprite;
      
      private var _checkboxes:Vector.<WomPigeonPostCheckBox>;
      
      public function PigeonPostWindow(param1:int = 528, param2:int = 404)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.pigeonpost.title";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _gentleHealerAsset = assetRepository.getDisplayObject("GentleHealerFull");
         addChild(_gentleHealerAsset);
         headerTextField = new WomTextField();
         headerTextField.multiline = true;
         headerTextField.wordWrap = true;
         headerTextField.width = 332;
         headerTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         addChild(headerTextField);
         var _temp_4:* = headerTextField;
         var _loc2_:String = "ui.windows.pigeonpost.header";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         headerTextField.autoSize = "left";
         checkBoxesBackground = assetRepository.getDisplayObject("BackgroundDark");
         checkBoxesBackground.width = 332;
         checkBoxesBackground.height = 202;
         addChild(checkBoxesBackground);
         helpBackground = assetRepository.getDisplayObject("BackgroundDark");
         helpBackground.width = 332;
         helpBackground.height = 43;
         addChild(helpBackground);
         _hintButton = new QuestHintButton();
         addChild(_hintButton);
         _helpTextField = new WomCustomCursorAwareTextField();
         _helpTextField.multiline = true;
         _helpTextField.wordWrap = true;
         _helpTextField.width = helpBackground.width - 90;
         _helpTextField.defaultTextFormat = WomTextFormats.UNDERLINE_16;
         addChild(_helpTextField);
         var _temp_10:* = _helpTextField;
         var _temp_9:* = "<a href=\'event:null\'>";
         var _loc3_:String = "ui.windows.pigeonpost.help";
         _temp_10.htmlText = _temp_9 + peak.i18n.PText.INSTANCE.getText0(_loc3_) + "</a>";
         _helpTextField.autoSize = "left";
         _scrollPane = new WomScrollPane();
         _scrollPane.width = 332 - 9;
         _scrollPane.height = 202 - 8;
         _scrollPane.verticalScrollPolicy = "off";
         _scrollPane.horizontalScrollPolicy = "off";
         addChild(_scrollPane);
         _scrollPaneContent = new Sprite();
         _checkboxes = new Vector.<WomPigeonPostCheckBox>();
         descTextField = new WomTextField();
         descTextField.multiline = true;
         descTextField.wordWrap = true;
         descTextField.width = 332;
         descTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         addChild(descTextField);
         var _temp_15:* = descTextField;
         var _loc4_:String = "ui.windows.pigeonpost.desc";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         descTextField.autoSize = "left";
         _saveCloseButton = new WomBlueLargeButton();
         _saveCloseButton.width = 219;
         var _temp_17:* = _saveCloseButton;
         var _loc5_:String = "ui.windows.pigeonpost.saveandclose";
         _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_saveCloseButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         AlignmentUtil.alignBelowOf(helpBackground,checkBoxesBackground,3);
         AlignmentUtil.alignAccordingToPositionOf(_hintButton,helpBackground,9,5);
         AlignmentUtil.alignAccordingToPositionOf(_helpTextField,helpBackground,45,3);
         AlignmentUtil.alignAccordingToPositionOf(_gentleHealerAsset,_background,-78,-19);
         AlignmentUtil.alignAccordingToPositionOf(headerTextField,_background,177,25);
         AlignmentUtil.alignAccordingToPositionOf(checkBoxesBackground,_background,177,63);
         AlignmentUtil.alignAccordingToPositionOf(_scrollPane,checkBoxesBackground,0,4);
         _loc1_ = 0;
         while(_loc1_ < _checkboxes.length)
         {
            _checkboxes[_loc1_].x = 11;
            _checkboxes[_loc1_].y = _loc1_ * 26 + 10;
            _loc1_++;
         }
         AlignmentUtil.alignAccordingToPositionOf(descTextField,_background,177,322);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_saveCloseButton,_background,361);
         _scrollPane.source = _scrollPaneContent;
      }
      
      private function createAndAddCheckBox(param1:Subscription, param2:String, param3:Number, param4:Boolean, param5:Boolean) : WomPigeonPostCheckBox
      {
         var _loc6_:WomPigeonPostCheckBox = new WomPigeonPostCheckBox(param1);
         _loc6_.label = param2;
         _loc6_.width = param3;
         _loc6_.selected = param4;
         _loc6_.enabled = param5;
         _scrollPaneContent.addChild(_loc6_);
         _checkboxes.push(_loc6_);
         return _loc6_;
      }
      
      public function update(param1:Vector.<int>, param2:BuildingTypeInfo) : void
      {
         var _loc3_:Boolean = false;
         clearCheckBoxes();
         for each(var _loc4_ in Subscription.availableSubscriptions)
         {
            _loc3_ = _loc4_ != Subscription.BEAST_HEALTH_IS_FULL && _loc4_ != Subscription.BEAST_READY_FOR_TRAINING || param2 && param2.currentInstanceCount > 0;
            §§push(§§findproperty(createAndAddCheckBox));
            §§push(_loc4_);
            var _loc7_:String = "notifications." + _loc4_.id + ".display";
            §§pop().createAndAddCheckBox(§§pop(),peak.i18n.PText.INSTANCE.getText0(_loc7_),300,!_loc3_ ? false : param1.indexOf(_loc4_.id) > -1,_loc3_);
         }
         drawLayout();
      }
      
      private function clearCheckBoxes() : void
      {
         var _loc2_:int = 0;
         var _loc1_:WomPigeonPostCheckBox = null;
         _loc2_ = 0;
         while(_loc2_ < _checkboxes.length)
         {
            _loc1_ = _checkboxes[_loc2_];
            if(_scrollPaneContent.contains(_loc1_))
            {
               _scrollPaneContent.removeChild(_loc1_);
            }
            _loc2_++;
         }
         _checkboxes.length = 0;
      }
      
      public function get gentleHealerAsset() : AssetDisplayObject
      {
         return _gentleHealerAsset;
      }
      
      public function get saveCloseButton() : WomButton
      {
         return _saveCloseButton;
      }
      
      public function get checkboxes() : Vector.<WomPigeonPostCheckBox>
      {
         return _checkboxes;
      }
      
      public function get helpTextField() : TextField
      {
         return _helpTextField;
      }
      
      public function get hintButton() : QuestHintButton
      {
         return _hintButton;
      }
   }
}

