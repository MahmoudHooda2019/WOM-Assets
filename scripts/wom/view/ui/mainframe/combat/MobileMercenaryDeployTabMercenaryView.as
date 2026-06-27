package wom.view.ui.mainframe.combat
{
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileMercenaryButtonView;
   
   public class MobileMercenaryDeployTabMercenaryView extends MobileMercenaryButtonView
   {
      
      private var shieldIcon:DisplayObject;
      
      private var levelTextField:MobileCaptionTextField;
      
      private var _unitTypeId:int;
      
      private var _unitLevel:int;
      
      private var _totalCount:int;
      
      private var _selectByTouch:Boolean;
      
      public function MobileMercenaryDeployTabMercenaryView(param1:UnitTypeDIO, param2:int)
      {
         super(param1);
         _unitTypeId = param2;
         _selectByTouch = true;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _mercButton.isToggle = true;
         _mercButton.isSelected = false;
         shieldIcon = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         shieldIcon.touchable = false;
         shieldIcon.width *= 37 / shieldIcon.width;
         shieldIcon.height *= 37 / shieldIcon.height;
         addChild(shieldIcon);
         levelTextField = new MobileCaptionTextField();
         levelTextField.touchable = false;
         levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         addChild(levelTextField);
         levelTextField.text = "" + _unitLevel;
      }
      
      override protected function createAndAddMercButton() : void
      {
         _mercButton = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large","ButtonWarMercSelected");
         _mercButton.width = 92;
         _mercButton.defaultIcon = _mercenaryPortrait;
         _mercButton.isToggle = true;
         _mercButton.isSelected = false;
         addChild(_mercButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleOf(levelTextField,shieldIcon);
         levelTextField.x -= 1;
         levelTextField.y += 2;
      }
      
      public function resetSelectionIfSelected() : void
      {
         if(_mercButton.isSelected)
         {
            _selectByTouch = false;
            _mercButton.isSelected = false;
            updateFilters();
         }
      }
      
      public function updateFilters() : void
      {
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get totalCount() : int
      {
         return _totalCount;
      }
      
      public function set totalCount(param1:int) : void
      {
         _totalCount = param1;
         selectionStatusText = "" + param1;
         _mercButton.isEnabled = param1 > 0;
         _mercenaryPortrait.alpha = param1 > 0 ? 1 : 0.5;
      }
      
      public function set unitLevel(param1:int) : void
      {
         _unitLevel = param1;
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

