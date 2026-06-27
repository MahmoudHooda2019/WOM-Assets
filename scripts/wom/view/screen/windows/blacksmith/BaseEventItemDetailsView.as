package wom.view.screen.windows.blacksmith
{
   import flash.display.Sprite;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.ui.common.ResourceGroupView;
   
   public class BaseEventItemDetailsView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _eventItemTypeDIO:EventItemDIO;
      
      private var _label1:CaptionTextField;
      
      private var _label2:CaptionTextField;
      
      protected var _damageLabel:CaptionTextField;
      
      protected var _timeLabel:CaptionTextField;
      
      private var _resourceInfoPanel:ResourceGroupView;
      
      private var resourceGroupBackground:AssetDisplayObject;
      
      private var costLabel:CaptionTextField;
      
      private var _textField1:WomTextField;
      
      private var _textField2:WomTextField;
      
      protected var _damageTextField:WomTextField;
      
      private var _timeTextField:WomTextField;
      
      public function BaseEventItemDetailsView(param1:EventItemDIO)
      {
         super();
         _eventItemTypeDIO = param1;
      }
      
      private static function createLabel() : CaptionTextField
      {
         var _loc1_:CaptionTextField = new CaptionTextField(WomTextFormats.LIGHT_BROWN_FILTER);
         _loc1_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         return _loc1_;
      }
      
      private static function createTextField() : WomTextField
      {
         var _loc1_:WomTextField = new WomTextField();
         _loc1_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _loc1_.multiline = false;
         return _loc1_;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         createAndAddInfoLabels();
         createAndAddInfoTextFields();
         resourceGroupBackground = assetRepository.getDisplayObject("BackgroundLight");
         resourceGroupBackground.width = 170;
         resourceGroupBackground.height = 92;
         addChild(resourceGroupBackground);
         _resourceInfoPanel = new ResourceGroupView(false,-25,0.74,50);
         addChild(_resourceInfoPanel);
         costLabel = createLabel();
         var _temp_4:* = costLabel;
         var _loc1_:String = "ui.windows.build.cost";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + ":";
         addChild(costLabel);
      }
      
      private function createAndAddInfoLabels() : void
      {
         _label1 = createLabel();
         addChild(_label1);
         _label2 = createLabel();
         addChild(_label2);
         _damageLabel = createLabel();
         var _temp_4:* = _damageLabel;
         var _loc1_:String = "ui.windows.eventstore.damage";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + ":";
         addChild(_damageLabel);
         _timeLabel = createLabel();
         var _temp_6:* = _timeLabel;
         var _loc2_:String = "ui.windows.trainingchamber.time";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc2_) + ":";
         addChild(_timeLabel);
      }
      
      private function createAndAddInfoTextFields() : void
      {
         _textField1 = createTextField();
         addChild(_textField1);
         _textField2 = createTextField();
         addChild(_textField2);
         _damageTextField = createTextField();
         addChild(_damageTextField);
         _timeTextField = createTextField();
         addChild(_timeTextField);
      }
      
      public function drawLayout() : void
      {
         _label1.x = 2;
         _label1.y = 0;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_textField1,_label1,63);
         AlignmentUtil.alignAccordingToPositionOf(_label2,_label1,0,24);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_textField2,_label2,63);
         AlignmentUtil.alignAccordingToPositionOf(_damageLabel,_label1,0,48);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_damageTextField,_damageLabel,63);
         AlignmentUtil.alignAccordingToPositionOf(_timeLabel,_label1,0,72);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_timeTextField,_timeLabel,63);
         resourceGroupBackground.x = 117;
         resourceGroupBackground.y = 0;
         AlignmentUtil.alignMiddleOf(_resourceInfoPanel,resourceGroupBackground);
         AlignmentUtil.alignAccordingToPositionOf(costLabel,resourceGroupBackground,10,-10);
      }
      
      public function updateResourceCosts(param1:Vector.<ResourceAmountDTO>) : void
      {
         _resourceInfoPanel.updateWithResources(param1);
         drawLayout();
      }
      
      public function get label1() : CaptionTextField
      {
         return _label1;
      }
      
      public function get label2() : CaptionTextField
      {
         return _label2;
      }
      
      public function set damageTextField(param1:WomTextField) : void
      {
         _damageTextField = param1;
      }
      
      public function get timeTextField() : WomTextField
      {
         return _timeTextField;
      }
      
      public function get textField1() : WomTextField
      {
         return _textField1;
      }
      
      public function get textField2() : WomTextField
      {
         return _textField2;
      }
      
      public function get damageTextField() : WomTextField
      {
         return _damageTextField;
      }
      
      public function get eventItemTypeDIO() : EventItemDIO
      {
         return _eventItemTypeDIO;
      }
   }
}

