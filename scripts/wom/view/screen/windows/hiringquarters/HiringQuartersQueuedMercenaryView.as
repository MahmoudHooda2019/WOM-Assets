package wom.view.screen.windows.hiringquarters
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.display.CustomCursorAwareSprite;
   import peak.display.View;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class HiringQuartersQueuedMercenaryView extends CustomCursorAwareSprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var mercenaryAsset:DisplayObject;
      
      private var counterBackground:DisplayObject;
      
      private var countTextField:TextField;
      
      private var _unitTypeId:int;
      
      private var numberOfUnits:int;
      
      private var _slotIndex:int;
      
      private var _buildingInstanceId:int;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      public function HiringQuartersQueuedMercenaryView(param1:int, param2:Number, param3:int, param4:int)
      {
         super();
         _unitTypeId = param1;
         _buildingInstanceId = param4;
         this.numberOfUnits = param2;
         _slotIndex = param3;
      }
      
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         mouseChildren = false;
         mercenaryAsset = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Medium");
         addChild(mercenaryAsset);
         counterBackground = assetRepository.getDisplayObject("CentralHiringNumber");
         addChild(counterBackground);
         countTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         countTextField.defaultTextFormat = WomTextFormats.CENTER_20;
         countTextField.height = 20;
         countTextField.width = 28;
         countTextField.text = numberOfUnits + "";
         addChild(countTextField);
      }
      
      public function drawLayout() : void
      {
         counterBackground.y = 75;
         AlignmentUtil.alignAccordingToPositionOf(countTextField,counterBackground,0,0);
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function set unitTypeDIO(param1:UnitTypeDIO) : void
      {
         _unitTypeDIO = param1;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get slotIndex() : int
      {
         return _slotIndex;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
   }
}

