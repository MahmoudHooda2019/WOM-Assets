package wom.view.screen.windows.store
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import wom.model.game.store.StoreInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileStoreItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var storeInfo:StoreInfo;
      
      private var _storeItemView:MobileStoreItemView;
      
      private var _storeItemInfoView:MobileStoreItemInfoView;
      
      private var _storeItemData:Object;
      
      public function MobileStoreItemRenderer(param1:MobileWomAssetRepository, param2:StoreInfo)
      {
         super();
         this.assetRepository = param1;
         this.storeInfo = param2;
      }
      
      override public function get data() : Object
      {
         return _storeItemData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _storeItemData = param1;
            storeItemView.updateStoreItemInfo(_storeItemData.storeItemInfo);
            storeItemInfoView.updateStoreItemInfo(_storeItemData.storeItemInfo);
            toggleViews();
         }
      }
      
      public function onHintButtonClicked() : void
      {
         if(storeItemInfoView.storeItem == null)
         {
            storeItemInfoView.updateStoreItemInfo(_storeItemData.storeItemInfo);
         }
         if(storeItemView.storeItem == null)
         {
            storeItemView.updateStoreItemInfo(_storeItemData.storeItemInfo);
         }
         _storeItemData.showStoreItemView = MobileWomUIComponentFactory.addFlipTween(storeItemView,storeItemInfoView,_storeItemData.showStoreItemView,toggleViews);
      }
      
      private function toggleViews() : void
      {
         storeItemView.visible = _storeItemData.showStoreItemView;
         storeItemInfoView.visible = !_storeItemData.showStoreItemView;
      }
      
      public function get storeItemView() : MobileStoreItemView
      {
         if(!_storeItemView)
         {
            _storeItemView = new MobileStoreItemView(assetRepository,storeInfo);
            addChild(_storeItemView);
            _storeItemView.y = 10;
         }
         return _storeItemView;
      }
      
      public function get storeItemInfoView() : MobileStoreItemInfoView
      {
         if(!_storeItemInfoView)
         {
            _storeItemInfoView = new MobileStoreItemInfoView(assetRepository);
            addChild(_storeItemInfoView);
            _storeItemInfoView.y = 10;
         }
         return _storeItemInfoView;
      }
      
      public function get storeItemData() : Object
      {
         return _storeItemData;
      }
   }
}

