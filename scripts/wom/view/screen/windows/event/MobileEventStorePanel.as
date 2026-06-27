package wom.view.screen.windows.event
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import peak.util.MobileAlignmentUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.event.EventItemUtil2;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.component.MobileWomCarousel;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileEventStorePanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 798;
      
      private static const HEIGHT:int = 541;
      
      private var _itemList:MobileWomCarousel;
      
      private var _height:int;
      
      private var _width:int;
      
      private var _allowItemUnlocking:Boolean;
      
      public function MobileEventStorePanel(param1:Boolean, param2:int = 798, param3:int = 541)
      {
         super(param2,param3);
         _allowItemUnlocking = param1;
         _width = param2;
         _height = param3;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _itemList = MobileWomUIComponentFactory.createCarousel("horizontal",_width - 356 >> 1,356,502);
         _itemList.itemRendererFactory = eventStoreRendererFactory;
         _itemList.width = _width - 4;
         _itemList.height = _height;
         addChild(_itemList);
         drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      public function fillItems(param1:Vector.<StoreItemInfo>, param2:Vector.<EventItemDIO>, param3:Array, param4:Vector.<int>) : void
      {
         var _loc6_:int = 0;
         var _loc5_:Array = [];
         for each(var _loc7_ in param2)
         {
            _loc5_.push({
               "eventStoreItemInfo":param1[_loc6_],
               "eventItemDIO":param2[_loc6_],
               "itemSpecificDIO":param3[_loc6_],
               "isLocked":EventItemUtil2.isEventItemLocked(_loc7_,param4),
               "showItemView":true
            });
            _loc6_++;
         }
         _itemList.dataProvider = new ListCollection(_loc5_);
         drawLayout();
      }
      
      public function updateAllItems(param1:Vector.<StoreItemInfo>, param2:Vector.<EventItemDIO>, param3:Array, param4:Vector.<int>) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         for each(var _loc7_ in param2)
         {
            _loc5_ = Boolean(_itemList.dataProvider.getItemAt(_loc6_).showItemView);
            _itemList.dataProvider.setItemAt({
               "eventStoreItemInfo":param1[_loc6_],
               "eventItemDIO":param2[_loc6_],
               "itemSpecificDIO":param3[_loc6_],
               "isLocked":EventItemUtil2.isEventItemLocked(_loc7_,param4),
               "showItemView":_loc5_
            },_loc6_);
            _loc6_++;
         }
         drawLayout();
      }
      
      private function eventStoreRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileEventStoreItemViewRenderer = new MobileEventStoreItemViewRenderer(assetRepository);
         _loc1_.width = 356;
         _loc1_.height = _height;
         return _loc1_;
      }
      
      public function get itemList() : MobileWomCarousel
      {
         return _itemList;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleOf(_itemList,bg);
      }
      
      public function get allowItemUnlocking() : Boolean
      {
         return _allowItemUnlocking;
      }
   }
}

