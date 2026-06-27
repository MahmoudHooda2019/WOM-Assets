package wom.view.screen.windows.tavern
{
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.screen.windows.tavern.unlock.MobileTavernUnlockedBeastView;
   import wom.view.screen.windows.tavern.unlock.MobileTavernUnlockedCardView;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileTavernUnlockPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 751;
      
      private static const HEIGHT:int = 154;
      
      private var _arrowAsset:DisplayObject;
      
      private var _unlockedCardViews:Vector.<MobileTavernUnlockedCardView>;
      
      private var _unlockedBeastView:MobileTavernUnlockedBeastView;
      
      public function MobileTavernUnlockPanel()
      {
         super(751,154);
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "MobileBeigeBackground";
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _arrowAsset = assetRepository.getDisplayObject("SymbolDubbleArrow");
         addChild(_arrowAsset);
         _unlockedCardViews = new Vector.<MobileTavernUnlockedCardView>();
         _unlockedCardViews.push(new MobileTavernUnlockedCardView(1));
         _unlockedCardViews.push(new MobileTavernUnlockedCardView(1));
         _unlockedCardViews.push(new MobileTavernUnlockedCardView(2));
         _unlockedCardViews.push(new MobileTavernUnlockedCardView(2));
         _unlockedCardViews.push(new MobileTavernUnlockedCardView(3));
         _unlockedCardViews.push(new MobileTavernUnlockedCardView(3));
         for each(var _loc1_ in _unlockedCardViews)
         {
            addChild(_loc1_);
         }
         _unlockedBeastView = new MobileTavernUnlockedBeastView();
         addChild(_unlockedBeastView);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 0;
         super.drawLayout();
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_unlockedCardViews[_loc1_],bg,_loc1_ * 98 + 20,19);
            _loc1_++;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_arrowAsset,bg,609,48);
         MobileAlignmentUtil.alignAccordingToPositionOf(_unlockedBeastView,bg,640,16);
      }
      
      public function get unlockedCardViews() : Vector.<MobileTavernUnlockedCardView>
      {
         return _unlockedCardViews;
      }
   }
}

