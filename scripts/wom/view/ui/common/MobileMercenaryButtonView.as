package wom.view.ui.common
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileMercenaryButtonView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _mercenaryPortrait:DisplayObject;
      
      protected var _visibleHeight:int;
      
      protected var _visibleWidth:int;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      protected var _selectionStatusTextField:MPTextField;
      
      protected var _mercButton:MPButton;
      
      public function MobileMercenaryButtonView(param1:UnitTypeDIO, param2:int = 0, param3:int = 0)
      {
         this._unitTypeDIO = param1;
         this._visibleHeight = param3;
         this._visibleWidth = param2;
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         initMercPortrait();
         createAndAddMercButton();
         _selectionStatusTextField = new MobileCaptionTextField();
         _selectionStatusTextField.touchable = false;
         _selectionStatusTextField.width = 92;
         _selectionStatusTextField.text = "0";
         _selectionStatusTextField.isEnabled = false;
         _selectionStatusTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         addChild(_selectionStatusTextField);
      }
      
      protected function createAndAddMercButton() : void
      {
         _mercButton = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
         _mercButton.width = 92;
         _mercButton.defaultIcon = _mercenaryPortrait;
         addChild(_mercButton);
      }
      
      protected function initMercPortrait() : void
      {
         _mercenaryPortrait = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Portrait");
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_selectionStatusTextField,_mercButton,0,61);
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function get mercButton() : MPButton
      {
         return _mercButton;
      }
      
      public function set mercButton(param1:MPButton) : void
      {
         _mercButton = param1;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth;
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
      
      public function set unitTypeInfo(param1:UnitTypeInfo) : void
      {
         _unitTypeInfo = param1;
      }
      
      public function get mercenaryPortrait() : DisplayObject
      {
         return _mercenaryPortrait;
      }
      
      public function set mercenaryPortrait(param1:DisplayObject) : void
      {
         _mercenaryPortrait = param1;
      }
      
      public function set selectionStatusText(param1:String) : void
      {
         _selectionStatusTextField.text = param1;
      }
      
      public function set unitTypeDIO(param1:UnitTypeDIO) : void
      {
         _unitTypeDIO = param1;
      }
   }
}

