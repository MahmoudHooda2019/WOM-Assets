package wom.view.screen.popups.event
{
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.ui.common.MobileIconLabelViewExtra;
   
   public class MobileEventRewardView extends Sprite implements View
   {
      
      private var unlockPriceView:MobileIconLabelViewExtra;
      
      private var itemBackground:DisplayObject;
      
      private var rewardAsset:DisplayObject;
      
      private var _unlockPrice:int;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var assetId:String;
      
      public function MobileEventRewardView(param1:MobileWomAssetRepository, param2:String, param3:int)
      {
         super();
         this.assetRepository = param1;
         this.assetId = param2;
         _unlockPrice = param3;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         itemBackground = assetRepository.getDisplayObject("MobileBackgroundBeige");
         itemBackground.width = 86;
         itemBackground.height = 86;
         addChild(itemBackground);
         rewardAsset = assetRepository.getDisplayObject(assetId);
         addChild(rewardAsset);
         unlockPriceView = new MobileIconLabelViewExtra("IconEP",_unlockPrice.toString());
         unlockPriceView.iconAlign = "left";
         unlockPriceView.textAlign = "left";
         unlockPriceView.textMarginFromIconX = 16;
         addChild(unlockPriceView);
      }
      
      public function drawLayout() : void
      {
         if(itemBackground.height - 11 < rewardAsset.height)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(rewardAsset,itemBackground,itemBackground.height - rewardAsset.height - 14);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleOf(rewardAsset,itemBackground);
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(unlockPriceView,itemBackground,74);
      }
      
      public function get unlockPrice() : int
      {
         return _unlockPrice;
      }
   }
}

