package wom.view.screen.windows.event
{
   import feathers.controls.renderers.IListItemRenderer;
   import flash.geom.Rectangle;
   import peak.component.mobile.MPItemRenderer;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileEventStoreItemViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _itemData:Object;
      
      private var _itemView:MobileEventStoreItemView;
      
      private var _itemInfoView:MobileEventStoreItemInfoView;
      
      private var assetRepository:MobileWomAssetRepository;
      
      public function MobileEventStoreItemViewRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         this.clipRect = new Rectangle(0,0,344,532);
      }
      
      override public function get data() : Object
      {
         return _itemData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _itemData = param1;
            if(_itemData.showItemView)
            {
               itemView.updateItemData(_itemData);
            }
            else
            {
               itemInfoView.updateItemData(_itemData);
            }
            toggleViews();
         }
      }
      
      public function onHintButtonClicked() : void
      {
         itemInfoView.updateItemData(_itemData);
         itemView.updateItemData(_itemData);
         _itemData.showItemView = MobileWomUIComponentFactory.addFlipTween(itemView,itemInfoView,_itemData.showItemView,toggleViews);
      }
      
      private function toggleViews() : void
      {
         itemView.visible = _itemData.showItemView;
         itemInfoView.visible = !_itemData.showItemView;
      }
      
      public function get itemView() : MobileEventStoreItemView
      {
         if(!_itemView)
         {
            _itemView = new MobileEventStoreItemView(this.assetRepository);
            addChild(_itemView);
         }
         return _itemView;
      }
      
      public function get itemInfoView() : MobileEventStoreItemInfoView
      {
         if(!_itemInfoView)
         {
            _itemInfoView = new MobileEventStoreItemInfoView(this.assetRepository);
            addChild(_itemInfoView);
         }
         return _itemInfoView;
      }
   }
}

