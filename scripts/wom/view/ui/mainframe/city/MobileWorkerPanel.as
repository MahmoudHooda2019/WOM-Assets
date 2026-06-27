package wom.view.ui.mainframe.city
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.mainframe.city.tooltip.WorkerPanelTooltip;
   
   public class MobileWorkerPanel extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var background:DisplayObject;
      
      protected var workerLabel:MPTextField;
      
      protected var _workerStatusTextField:MPTextField;
      
      protected var _workerAddButton:MPRigidButton;
      
      public var tooltip:WorkerPanelTooltip;
      
      protected var _cityHasMaxWorkers:Boolean;
      
      public function MobileWorkerPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      protected function initLayout() : void
      {
         _cityHasMaxWorkers = false;
         background = assetRepository.getDisplayObject("BackgroundYellowPanel");
         background.width = 88;
         background.height = 45;
         addChild(background);
         workerLabel = new MobileCaptionTextField();
         workerLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         workerLabel.textRendererProperties.textColor = 3548944;
         var _temp_4:* = workerLabel;
         var _loc1_:String = "ui.mainframe.city.workers";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(workerLabel);
         _workerStatusTextField = new MobileCaptionTextField();
         _workerStatusTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(_workerStatusTextField);
         _workerAddButton = new MPRigidButton("IconGreenAdd","IconGreenAddHover");
         addChild(_workerAddButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(workerLabel,background,3,-17);
         _workerAddButton.validate();
         _workerStatusTextField.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_workerStatusTextField,background,(_workerAddButton.visible ? 52 : 88) - _workerStatusTextField.width - 2 >> 1,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(_workerAddButton,background,51,6);
      }
      
      public function get workerStatusTextField() : MPTextField
      {
         return _workerStatusTextField;
      }
      
      public function get workerAddButton() : MPButton
      {
         return _workerAddButton;
      }
      
      public function get cityHasMaxWorkers() : Boolean
      {
         return _cityHasMaxWorkers;
      }
      
      public function set cityHasMaxWorkers(param1:Boolean) : void
      {
         _cityHasMaxWorkers = param1;
      }
   }
}

