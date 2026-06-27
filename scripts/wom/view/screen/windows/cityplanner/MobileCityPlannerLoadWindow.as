package wom.view.screen.windows.cityplanner
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPList;
   import peak.i18n.PText;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileCityPlannerLoadWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 813;
      
      private static const WINDOW_HEIGHT:int = 678;
      
      private var _planList:MPList;
      
      public function MobileCityPlannerLoadWindow()
      {
         super(813,678);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.cityplanner.loadlayout";
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
         var _loc1_:MobileCityPlannerLoadLayoutRenderer = new MobileCityPlannerLoadLayoutRenderer(assetRepository,true);
         _loc1_.width = 753;
         _loc1_.height = 126;
         return _loc1_;
      }
      
      public function updateWithCityInfo(param1:Dictionary, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc6_:Vector.<Object> = new Vector.<Object>();
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc4_ = _loc5_ + 1;
            _loc3_ = _loc4_ in param1 ? param1[_loc4_].name : "";
            _loc6_.push({
               "slotNum":_loc4_,
               "name":_loc3_
            });
            _loc5_++;
         }
         _planList.dataProvider = new ListCollection(_loc6_);
         _planList.validate();
      }
      
      public function get planList() : MPList
      {
         return _planList;
      }
   }
}

