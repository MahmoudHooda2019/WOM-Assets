package wom.view.screen.windows.hiringquarters
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import peak.display.CustomCursorAwareSprite;
   import peak.display.View;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class HiringQuartersMercenaryView extends CustomCursorAwareSprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var _index:int;
      
      private var _mercenaryAsset:DisplayObject;
      
      private var shieldIcon:DisplayObject;
      
      private var assetColorTransform:ColorTransform;
      
      private var _levelTextField:TextField;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var reference:int = 0;
      
      public function HiringQuartersMercenaryView(param1:UnitTypeDIO, param2:int)
      {
         super();
         _unitTypeDIO = param1;
         _index = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         mouseChildren = false;
         _mercenaryAsset = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Small");
         addChild(_mercenaryAsset);
         shieldIcon = assetRepository.getDisplayObject("MercenaryLevel41Px");
         shieldIcon.scaleX = shieldIcon.scaleY = 0.5609756097560976;
         addChild(shieldIcon);
         _levelTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _levelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         _levelTextField.autoSize = "left";
         addChild(_levelTextField);
         assetColorTransform = new ColorTransform();
      }
      
      public function drawLayout() : void
      {
         _mercenaryAsset.x = _mercenaryAsset.y = reference;
         AlignmentUtil.alignAccordingToPositionOf(shieldIcon,_mercenaryAsset,31 - reference,31 - reference);
         AlignmentUtil.alignAccordingToPositionOf(_levelTextField,shieldIcon,7,-2);
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function updateUnit(param1:UnitTypeInfo) : void
      {
         _unitTypeInfo = param1;
         _levelTextField.text = param1.currentLevel + "";
         alpha = (buttonMode = param1.recruited) ? 1 : 0.5;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
      
      public function get mercenaryAsset() : DisplayObject
      {
         return _mercenaryAsset;
      }
      
      public function enlargedView() : void
      {
         _mercenaryAsset.scaleX = _mercenaryAsset.scaleY = 1.08;
         reference = -2;
         drawLayout();
      }
      
      public function normalView() : void
      {
         _mercenaryAsset.scaleX = _mercenaryAsset.scaleY = 1;
         reference = 0;
         drawLayout();
      }
      
      public function updateSelected(param1:Boolean) : void
      {
      }
   }
}

