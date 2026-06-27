package wom.view.screen.windows.blacksmith
{
   import peak.util.AlignmentUtil;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.view.util.BaseWindowPanel;
   
   public class BlacksmithInventoryPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 618;
      
      private static const HEIGHT:int = 250;
      
      private var inventorySlotViewsArray:Array;
      
      private var _blacksmithCurrentLevel:int;
      
      public function BlacksmithInventoryPanel()
      {
         super(618,250);
         inventorySlotViewsArray = [];
      }
      
      public function createAndFillSlots(param1:Vector.<EventInventoryItemInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BlacksmithInventorySlotView = null;
         if(inventorySlotViewsArray.length > 0)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc2_ = new BlacksmithInventorySlotView(_loc4_ < param1.length ? param1[_loc4_] : null,_loc4_,_blacksmithCurrentLevel);
            inventorySlotViewsArray.push(_loc2_);
            _loc5_ = _loc4_ > 5 ? (_loc4_ - 6) * 104 : _loc4_ * 104;
            _loc3_ = _loc4_ > 5 ? 160 : 0;
            AlignmentUtil.alignAccordingToPositionOf(_loc2_,bg,_loc5_,_loc3_);
            addChild(inventorySlotViewsArray[_loc4_]);
            _loc4_++;
         }
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      public function set blacksmithCurrentLevel(param1:int) : void
      {
         _blacksmithCurrentLevel = param1;
      }
   }
}

