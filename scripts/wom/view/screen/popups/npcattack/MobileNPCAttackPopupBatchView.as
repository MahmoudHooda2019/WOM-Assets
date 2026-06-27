package wom.view.screen.popups.npcattack
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileNPCAttackPopupBatchView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _unitInformation:UnitTypeAmountDTO;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var background:DisplayObject;
      
      private var mercenaryAsset:DisplayObject;
      
      private var amountTextField:MPTextField;
      
      public function MobileNPCAttackPopupBatchView(param1:UnitTypeAmountDTO)
      {
         super();
         _unitInformation = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("BeigeLargeBackground");
         background.width = 94;
         background.height = 93;
         addChild(background);
         mercenaryAsset = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Portrait");
         addChild(mercenaryAsset);
         amountTextField = new MobileCaptionTextField();
         amountTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(amountTextField);
         amountTextField.text = _unitInformation.amount + "";
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(mercenaryAsset,background);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(amountTextField,background,60);
      }
      
      public function set unitTypeDIO(param1:UnitTypeDIO) : void
      {
         _unitTypeDIO = param1;
      }
      
      public function get unitInformation() : UnitTypeAmountDTO
      {
         return _unitInformation;
      }
   }
}

