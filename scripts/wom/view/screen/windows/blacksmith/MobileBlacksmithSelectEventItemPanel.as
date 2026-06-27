package wom.view.screen.windows.blacksmith
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import peak.component.mobile.MPList;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.event.EventItemUtil2;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileBlacksmithSelectEventItemPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 761;
      
      private static const HEIGHT:int = 395;
      
      private var eventItemListBackground:DisplayObject;
      
      private var _eventItemList:MPList;
      
      private var _eventItemInfoPanel:MobileBlacksmithEventItemInfoPanel;
      
      public function MobileBlacksmithSelectEventItemPanel()
      {
         super(761,395);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         eventItemListBackground = assetRepository.getDisplayObject("BackgroundBeige");
         eventItemListBackground.width = 761;
         eventItemListBackground.height = 147;
         addChild(eventItemListBackground);
         _eventItemList = new MPList();
         _eventItemList.itemRendererFactory = blacksmithEventItemRendererFactory;
         var _loc1_:TiledColumnsLayout = new TiledColumnsLayout();
         _loc1_.gap = 20;
         _loc1_.useSquareTiles = false;
         _eventItemList.x = 27;
         _eventItemList.y = 14;
         _eventItemList.layout = _loc1_;
         _eventItemList.width = 713;
         _eventItemList.height = 107;
         addChild(_eventItemList);
         _eventItemInfoPanel = new MobileBlacksmithEventItemInfoPanel();
         addChild(_eventItemInfoPanel);
         drawLayout();
      }
      
      public function fillEventItems(param1:Vector.<Object>, param2:Vector.<int>) : void
      {
         var _loc7_:EventItemDIO = null;
         var _loc6_:UnitTypeInfo = null;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         for each(var _loc5_ in param1)
         {
            _loc7_ = _loc5_.eventItemDIO;
            _loc6_ = _loc5_.unitTypeInfo;
            _loc3_.push({
               "eventItemDIO":_loc7_,
               "isLocked":EventItemUtil2.isEventItemLocked(_loc7_,param2),
               "unitTypeInfo":_loc6_
            });
            _loc4_++;
         }
         while(_loc4_ < 15)
         {
            _loc3_.push({"eventItemDIO":null});
            _loc4_++;
         }
         _eventItemList.dataProvider = new ListCollection(_loc3_);
      }
      
      public function updateEventItems(param1:Vector.<Object>, param2:Vector.<int>) : void
      {
         var _loc6_:EventItemDIO = null;
         var _loc5_:UnitTypeInfo = null;
         var _loc3_:int = 0;
         for each(var _loc4_ in param1)
         {
            _loc6_ = _loc4_.eventItemDIO;
            _loc5_ = _loc4_.unitTypeInfo;
            _eventItemList.dataProvider.setItemAt({
               "eventItemDIO":_loc6_,
               "isLocked":EventItemUtil2.isEventItemLocked(_loc6_,param2),
               "unitTypeInfo":_loc5_
            },_loc3_);
            _loc3_++;
         }
         while(_loc3_ < 15)
         {
            _eventItemList.dataProvider.setItemAt({"eventItemDIO":null},_loc3_);
            _loc3_++;
         }
      }
      
      private function blacksmithEventItemRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileBlacksmithEventItemRenderer = new MobileBlacksmithEventItemRenderer(assetRepository);
         _loc1_.width = 93;
         _loc1_.height = 107;
         return _loc1_;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignBelowOf(_eventItemInfoPanel,eventItemListBackground,6);
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      public function updateCatapultDetails(param1:CatapultTypeDIO, param2:Array) : void
      {
         _eventItemInfoPanel.updateCatapultDetails(param1,param2);
      }
      
      public function updateUnitDetails(param1:UnitTypeDIO, param2:UnitTypeInfo, param3:Array) : void
      {
         _eventItemInfoPanel.updateUnitDetails(param1,param2,param3);
      }
      
      public function get eventItemList() : MPList
      {
         return _eventItemList;
      }
      
      public function get eventItemInfoPanel() : MobileBlacksmithEventItemInfoPanel
      {
         return _eventItemInfoPanel;
      }
   }
}

