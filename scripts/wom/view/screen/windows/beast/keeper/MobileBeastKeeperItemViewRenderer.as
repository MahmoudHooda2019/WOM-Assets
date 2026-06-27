package wom.view.screen.windows.beast.keeper
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileBeastKeeperItemViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _beastData:Object;
      
      private var _beastView:MobileBeastKeeperItemView;
      
      private var _beastInfoView:MobileBeastKeeperItemInfoView;
      
      private var assetRepository:MobileWomAssetRepository;
      
      public function MobileBeastKeeperItemViewRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
      }
      
      override public function get data() : Object
      {
         return _beastData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _beastData = param1;
            if(_beastData.showBeastView)
            {
               beastView.updateBeastData(_beastData);
            }
            else
            {
               beastInfoView.updateBeastData(_beastData);
            }
            toggleViews();
         }
      }
      
      public function onHintButtonClicked() : void
      {
         if(beastInfoView.data == null)
         {
            beastInfoView.updateBeastData(_beastData);
         }
         if(beastView.data == null)
         {
            beastView.updateBeastData(_beastData);
         }
         _beastData.showBeastView = MobileWomUIComponentFactory.addFlipTween(beastView,beastInfoView,_beastData.showBeastView,toggleViews);
      }
      
      private function toggleViews() : void
      {
         beastView.visible = _beastData.showBeastView;
         beastInfoView.visible = !_beastData.showBeastView;
      }
      
      public function get beastView() : MobileBeastKeeperItemView
      {
         if(!_beastView)
         {
            _beastView = new MobileBeastKeeperItemView(this.assetRepository);
            addChild(_beastView);
         }
         return _beastView;
      }
      
      public function get beastInfoView() : MobileBeastKeeperItemInfoView
      {
         if(!_beastInfoView)
         {
            _beastInfoView = new MobileBeastKeeperItemInfoView(this.assetRepository);
            addChild(_beastInfoView);
         }
         return _beastInfoView;
      }
   }
}

