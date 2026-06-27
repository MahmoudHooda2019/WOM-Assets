package wom.view.screen.windows.tuskhorn
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileMercenaryButtonView;
   
   public class MobileTuskHornMercenaryView extends MobileMercenaryButtonView
   {
      
      private static const WINDOW_WIDTH:int = 90;
      
      private static const WINDOW_HEIGHT:int = 94;
      
      private var _subButton:MPRigidButton;
      
      private var _shieldIcon:DisplayObject;
      
      private var _levelTextField:MPTextField;
      
      private var _selectedCount:int;
      
      public function MobileTuskHornMercenaryView(param1:UnitTypeDIO, param2:int = 90, param3:int = 94)
      {
         super(param1,param2,param3);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _shieldIcon = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         _shieldIcon.width = 37;
         _shieldIcon.height = 37;
         addChild(_shieldIcon);
         _levelTextField = new MobileCaptionTextField();
         _levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _levelTextField.text = "" + unitTypeInfo.currentLevel;
         addChild(_levelTextField);
         _subButton = new MPRigidButton("IconBlueSub","IconBlueSubHover");
         addChild(_subButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         _levelTextField.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_shieldIcon,_mercButton,-4,-6);
         MobileAlignmentUtil.alignAccordingToPositionOf(_subButton,_mercButton,64,-5);
         MobileAlignmentUtil.alignMiddleOf(_levelTextField,_shieldIcon);
         selectionStatusText = _selectedCount + "";
         if(_selectedCount < 1)
         {
            _subButton.isEnabled = false;
            _subButton.visible = false;
         }
         else
         {
            _subButton.isEnabled = true;
            _subButton.visible = true;
         }
      }
      
      public function get subButton() : MPRigidButton
      {
         return _subButton;
      }
      
      public function get shieldIcon() : DisplayObject
      {
         return _shieldIcon;
      }
      
      public function set shieldIcon(param1:DisplayObject) : void
      {
         _shieldIcon = param1;
      }
      
      public function get levelTextField() : MPTextField
      {
         return _levelTextField;
      }
      
      public function set levelTextField(param1:MPTextField) : void
      {
         _levelTextField = param1;
      }
      
      public function get selectedCount() : int
      {
         return _selectedCount;
      }
      
      public function set selectedCount(param1:int) : void
      {
         _selectedCount = param1;
         drawLayout();
      }
   }
}

