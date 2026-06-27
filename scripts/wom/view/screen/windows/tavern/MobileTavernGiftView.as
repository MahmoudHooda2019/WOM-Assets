package wom.view.screen.windows.tavern
{
   import com.greensock.TweenMax;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileLightAnimationView;
   
   public class MobileTavernGiftView extends Sprite implements View
   {
      
      public static const WIDTH:int = 100;
      
      private static const UNSTASHABLE_ITEM_ID:int = 10007;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _tavernItemDIO:TavernItemDIO;
      
      private var _lightAnimationView:MobileLightAnimationView;
      
      private var _giftAssetNameView:MobileTavernGiftAssetNameView;
      
      private var _addedToStashTF:MPTextField;
      
      public function MobileTavernGiftView(param1:TavernItemDIO)
      {
         super();
         _tavernItemDIO = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _lightAnimationView = new MobileLightAnimationView();
         _lightAnimationView.scaleX = _lightAnimationView.scaleY = 1.5;
         addChild(_lightAnimationView);
         _giftAssetNameView = new MobileTavernGiftAssetNameView(assetRepository,_tavernItemDIO);
         addChild(_giftAssetNameView);
         _addedToStashTF = new MobileCaptionTextField();
         _addedToStashTF.width = 120;
         _addedToStashTF.height = 20;
         _addedToStashTF.textRendererProperties.textFormat = getCaptionTextFormat(19);
         _addedToStashTF.alpha = 0;
         _addedToStashTF.visible = _tavernItemDIO.id != 10007;
         addChild(_addedToStashTF);
         var _temp_4:* = _addedToStashTF;
         var _loc2_:String = "ui.windows.tavern.addedtostash";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _giftAssetNameView.x = -(_giftAssetNameView.width >> 1);
         _giftAssetNameView.drawLayout();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_addedToStashTF,_giftAssetNameView,64);
      }
      
      public function startGiftAnimation() : void
      {
         _lightAnimationView.rotate(3.2);
         TweenMax.to(_giftAssetNameView,0.16,{
            "scaleX":1.5,
            "scaleY":1.5,
            "x":_giftAssetNameView.x - _giftAssetNameView.width * 0.35,
            "y":_giftAssetNameView.y - _giftAssetNameView.height * 0.35,
            "onComplete":returnToNormalSize
         });
      }
      
      private function returnToNormalSize() : void
      {
         TweenMax.to(_giftAssetNameView,0.2,{
            "scaleX":1,
            "scaleY":1,
            "x":-(_giftAssetNameView.width >> 1),
            "y":0
         });
         _addedToStashTF.y -= 15;
         TweenMax.to(_addedToStashTF,0.4,{
            "delay":0.3,
            "alpha":1,
            "y":_addedToStashTF.y + 15,
            "onComplete":removeAddedToStash
         });
      }
      
      private function removeAddedToStash() : void
      {
         TweenMax.to(_addedToStashTF,0.4,{
            "delay":1.3,
            "alpha":0,
            "y":_addedToStashTF.y + 15
         });
         TweenMax.to(_giftAssetNameView,0.2,{
            "delay":2,
            "scaleX":1.5,
            "scaleY":1.5,
            "x":_giftAssetNameView.x - _giftAssetNameView.width * 0.35,
            "y":_giftAssetNameView.y - _giftAssetNameView.height * 0.35,
            "onComplete":fadeOut
         });
      }
      
      private function fadeOut() : void
      {
         var _loc1_:Number = 0.4;
         TweenMax.to(_giftAssetNameView,_loc1_,{
            "alpha":0,
            "scaleX":0.2,
            "scaleY":0.2,
            "x":_giftAssetNameView.x + _giftAssetNameView.width * 0.4,
            "y":_giftAssetNameView.y + _giftAssetNameView.height * 0.4,
            "onComplete":hide
         });
         TweenMax.to(_lightAnimationView,_loc1_,{
            "scaleX":0.2,
            "scaleY":0.2
         });
      }
      
      private function hide() : void
      {
         this.visible = false;
      }
      
      public function get tavernItemAsset() : DisplayObject
      {
         return _giftAssetNameView.tavernItemAsset;
      }
   }
}

