package wom.view.screen.windows.store
{
   import wom.model.game.store.StoreItemCategory;
   
   public class StoreSpeedupsPanel extends StoreCategoryPanel
   {
      
      private var _instanceId:int;
      
      public function StoreSpeedupsPanel(param1:int, param2:Boolean = false)
      {
         super(param2 ? StoreItemCategory.BUILDING_SPEEDUPS : StoreItemCategory.SPEEDUPS);
         this._instanceId = param1;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

