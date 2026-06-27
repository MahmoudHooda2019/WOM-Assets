package wom.view.screen.windows.rank
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileRankView extends Sprite implements View
   {
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _rankTextField:MPTextField;
      
      private var _rankAsset:DisplayObject;
      
      private var _previousRank:int;
      
      public function MobileRankView(param1:MobileWomAssetRepository)
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
         _rankTextField = new MobileCaptionTextField();
         _rankTextField.width = 100;
         addChild(_rankTextField);
         _previousRank = 0;
      }
      
      public function updateWithRankInfo(param1:int) : void
      {
         var _loc2_:String = null;
         if(_previousRank != param1)
         {
            if(_rankAsset && contains(_rankAsset))
            {
               removeChild(_rankAsset);
            }
            _rankAsset = null;
            if(param1 <= 3)
            {
               _loc2_ = "IconRanking" + param1;
               _rankAsset = assetRepository.getDisplayObject(_loc2_);
               addChild(_rankAsset);
               setChildIndex(_rankTextField,1);
            }
            if(param1 <= 100 && (_previousRank > 100 || _previousRank == 0))
            {
               _rankTextField.textRendererProperties.textFormat = getCaptionTextFormat(42,"center");
            }
            else if(param1 > 100 && (_previousRank <= 100 || _previousRank == 0))
            {
               _rankTextField.textRendererProperties.textFormat = getCaptionTextFormat(25,"center");
            }
            _rankTextField.text = param1.toString();
            _previousRank = param1;
            drawLayout();
         }
      }
      
      public function drawLayout() : void
      {
         _rankTextField.validate();
         _rankTextField.x = -6;
         _rankTextField.y = 4;
         if(_rankAsset)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rankAsset,_rankTextField,-5);
            _rankAsset.x += 3;
         }
      }
   }
}

