package wom.view.screen.windows.beast.keeper
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.util.MobileAlignmentUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.beast.BeastStatusType;
   import wom.view.component.MobileWomCarousel;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileBeastKeeperPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 798;
      
      private static const HEIGHT:int = 541;
      
      private var _beastList:MobileWomCarousel;
      
      private var _height:int;
      
      private var _width:int;
      
      public function MobileBeastKeeperPanel(param1:int = 798, param2:int = 541)
      {
         super(param1,param2);
         _width = param1;
         _height = param2;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _beastList = MobileWomUIComponentFactory.createCarousel("horizontal",_width - 356 >> 1,356,502);
         _beastList.itemRendererFactory = beastKeeperRendererFactory;
         _beastList.width = _width - 4;
         _beastList.height = _height;
         addChild(_beastList);
         drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      public function updateAllBeastViews(param1:BeastInfo, param2:Dictionary, param3:Vector.<BeastTypeDIO>) : void
      {
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:BeastStatusType = null;
         var _loc7_:Boolean = false;
         var _loc4_:int = 0;
         for each(var _loc8_ in param3)
         {
            if(String(_loc8_.id) in param2)
            {
               _loc5_ = int(param2[_loc8_.id]["level"]);
               _loc9_ = int(param2[_loc8_.id]["bonusStage"]);
               _loc6_ = BeastStatusType.IN_KEEPER;
            }
            else if(param1 != null && param1.typeId == _loc8_.id)
            {
               _loc5_ = param1.level;
               _loc9_ = param1.bonusStage;
               _loc6_ = BeastStatusType.IN_CAVE;
            }
            else
            {
               _loc5_ = 1;
               _loc9_ = 0;
               _loc6_ = BeastStatusType.NON_RAISED;
            }
            _loc7_ = Boolean(_beastList.dataProvider.getItemAt(_loc4_).showBeastView);
            _beastList.dataProvider.setItemAt({
               "beastDIO":_loc8_,
               "beastLevel":_loc5_,
               "bonusStage":_loc9_,
               "beastStatusType":_loc6_,
               "showBeastView":_loc7_
            },_loc4_);
            _loc4_++;
         }
         drawLayout();
      }
      
      private function beastKeeperRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileBeastKeeperItemViewRenderer = new MobileBeastKeeperItemViewRenderer(assetRepository);
         _loc1_.width = 356;
         _loc1_.height = _height;
         return _loc1_;
      }
      
      public function get beastList() : MobileWomCarousel
      {
         return _beastList;
      }
      
      public function fillBeasts(param1:BeastInfo, param2:Dictionary, param3:Vector.<BeastTypeDIO>) : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:BeastStatusType = null;
         var _loc4_:Array = [];
         for each(var _loc7_ in param3)
         {
            if(String(_loc7_.id) in param2)
            {
               _loc5_ = int(param2[_loc7_.id]["level"]);
               _loc8_ = int(param2[_loc7_.id]["bonusStage"]);
               _loc6_ = BeastStatusType.IN_KEEPER;
            }
            else if(param1 != null && param1.typeId == _loc7_.id)
            {
               _loc5_ = param1.level;
               _loc8_ = param1.bonusStage;
               _loc6_ = BeastStatusType.IN_CAVE;
            }
            else
            {
               _loc5_ = 1;
               _loc8_ = 0;
               _loc6_ = BeastStatusType.NON_RAISED;
            }
            _loc4_.push({
               "beastDIO":_loc7_,
               "beastLevel":_loc5_,
               "bonusStage":_loc8_,
               "beastStatusType":_loc6_,
               "showBeastView":true
            });
         }
         _beastList.dataProvider = new ListCollection(_loc4_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleOf(_beastList,bg);
      }
   }
}

