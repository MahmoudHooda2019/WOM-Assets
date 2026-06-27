package wom.view.screen.windows
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPList;
   import peak.i18n.PText;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerSaveLayoutRenderer;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileCityPlannerSaveWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 813;
      
      private static const WINDOW_HEIGHT:int = 678;
      
      private static const MAX_SLOT_COUNT:int = 10;
      
      private var _planList:MPList;
      
      public function MobileCityPlannerSaveWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(813,678,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.cityplanner.savelayout";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _planList = new MPList();
         _planList.itemRendererFactory = cityPlanRenderer;
         _planList.x = 31;
         _planList.y = 33;
         _planList.height = 606;
         _planList.width = 753;
         addChild(_planList);
      }
      
      private function cityPlanRenderer() : IListItemRenderer
      {
         var _loc1_:MobileCityPlannerSaveLayoutRenderer = new MobileCityPlannerSaveLayoutRenderer(assetRepository,true);
         _loc1_.width = 753;
         _loc1_.height = 126;
         return _loc1_;
      }
      
      public function updateButtons(param1:int) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         _loc4_ = 1;
         while(_loc4_ < 10 + 1)
         {
            _loc2_ = _loc4_ > param1;
            _loc3_ = _planList.dataProvider.getItemAt(_loc4_ - 1);
            _loc3_.slotUnavailable = _loc2_;
            _loc3_.buttonsEnabled = _loc4_ <= param1 + 1;
            _planList.dataProvider.updateItemAt(_loc4_ - 1);
            _loc4_++;
         }
      }
      
      public function updateWithCityInfo(param1:Dictionary, param2:int, param3:Vector.<int>, param4:Vector.<int>) : void
      {
         var _loc6_:Boolean = false;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Vector.<Object> = new Vector.<Object>();
         _loc7_ = 1;
         while(_loc7_ < 10 + 1)
         {
            _loc6_ = _loc7_ > param2;
            _loc5_ = _loc7_ in param1 ? param1[_loc7_].name : "";
            _loc8_.push({
               "slotNum":_loc7_,
               "name":_loc5_,
               "slotUnavailable":_loc6_,
               "goldCost":param3[_loc7_ - 1],
               "rpCost":param4[_loc7_ - 1],
               "buttonsEnabled":_loc7_ <= param2 + 1
            });
            _loc7_++;
         }
         _planList.dataProvider = new ListCollection(_loc8_);
         _planList.validate();
      }
      
      public function get planList() : MPList
      {
         return _planList;
      }
   }
}

