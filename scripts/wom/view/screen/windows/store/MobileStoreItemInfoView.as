package wom.view.screen.windows.store
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.Sprite;
   import wom.model.game.store.StoreItemInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileStoreItemInfoView extends Sprite
   {
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _storeItem:StoreItemInfo;
      
      private var background:DisplayObject;
      
      private var descriptionTextField:MPTextField;
      
      private var seperatorLine:Quad = new Quad(206,1);
      
      private var sublineTextField:MPTextField;
      
      private var _hintButton:MPRigidButton;
      
      public function MobileStoreItemInfoView(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 260;
         background.height = 216;
         background.y = 11;
         addChild(background);
         descriptionTextField = new MobileWomTextField();
         descriptionTextField.width = 180;
         descriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         descriptionTextField.textRendererProperties.wordWrap = true;
         addChild(descriptionTextField);
         addChild(seperatorLine);
         sublineTextField = new MobileWomTextField();
         sublineTextField.width = 180;
         sublineTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         sublineTextField.textRendererProperties.wordWrap = true;
         addChild(sublineTextField);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         addChild(_hintButton);
         seperatorLine.color = 0;
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         background.y = 10;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descriptionTextField,background,47);
         MobileAlignmentUtil.alignBelowOf(sublineTextField,descriptionTextField,23);
         MobileAlignmentUtil.alignBelowWithXMarginOf(seperatorLine,descriptionTextField,-13,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,234,-10);
      }
      
      public function updateStoreItemInfo(param1:StoreItemInfo) : void
      {
         _storeItem = param1;
         descriptionTextField.text = _storeItem.description;
         descriptionTextField.alpha = _storeItem.locked ? 0.6 : 1;
         var _loc2_:Boolean = param1.subline != null;
         seperatorLine.visible = _loc2_;
         seperatorLine.alpha = _storeItem.locked ? 0.6 : 1;
         if(_loc2_)
         {
            sublineTextField.text = _storeItem.subline;
            sublineTextField.alpha = _storeItem.locked ? 0.6 : 1;
         }
         drawLayout();
      }
      
      public function get storeItem() : StoreItemInfo
      {
         return _storeItem;
      }
      
      public function get hintButton() : MPRigidButton
      {
         return _hintButton;
      }
   }
}

