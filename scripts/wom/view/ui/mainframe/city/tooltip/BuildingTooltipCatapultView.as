package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.attack.CatapultTimeDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.ui.common.IconLabelView;
   
   public class BuildingTooltipCatapultView extends Sprite
   {
      
      private var _lumberCatapultView:IconLabelView;
      
      private var _stoneCatapultView:IconLabelView;
      
      private var _mightCatapultView:IconLabelView;
      
      public var assetRepository:WomAssetRepository;
      
      public function BuildingTooltipCatapultView(param1:WomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _lumberCatapultView = new IconLabelView("CatapultLumber32","",55,48,null,null,false);
         _stoneCatapultView = new IconLabelView("CatapultStone32","",55,48,null,null,false);
         _mightCatapultView = new IconLabelView("CatapultMight32","",55,48,null,null,false);
         addChild(_lumberCatapultView);
         addChild(_stoneCatapultView);
         addChild(_mightCatapultView);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _lumberCatapultView.x = 7;
         AlignmentUtil.alignRightOf(_stoneCatapultView,_lumberCatapultView,0);
         AlignmentUtil.alignRightOf(_mightCatapultView,_stoneCatapultView,0);
      }
      
      public function updateWithData(param1:Dictionary, param2:int) : void
      {
         updateCatapultViewLabel(_lumberCatapultView,param1[1],1 <= param2);
         updateCatapultViewLabel(_stoneCatapultView,param1[2],2 <= param2);
         updateCatapultViewLabel(_mightCatapultView,param1[3],3 <= param2);
         drawLayout();
      }
      
      private function updateCatapultViewLabel(param1:IconLabelView, param2:CatapultTimeDTO, param3:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = param2.catapultTime;
         if(param3)
         {
            param1.icon.alpha = 1;
            if(_loc5_ <= 0)
            {
               var _temp_1:* = param1;
               var _loc7_:String = "ui.mainframe.city.tooltip.catapultready";
               _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            }
            else
            {
               _loc6_ = _loc5_ / 1000;
               _loc4_ = _loc6_ / 60;
               _loc6_ %= 60;
               _loc4_ %= 60;
               param1.label = (_loc4_ < 10 ? "0" : "") + _loc4_ + ":" + ((_loc6_ < 10 ? "0" : "") + _loc6_);
            }
         }
         else
         {
            param1.icon.alpha = 0.5;
            var _temp_3:* = param1;
            var _loc8_:String = "ui.mainframe.city.tooltip.catapultlocked";
            _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         }
      }
   }
}

