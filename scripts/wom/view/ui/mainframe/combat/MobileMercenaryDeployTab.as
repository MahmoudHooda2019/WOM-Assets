package wom.view.ui.mainframe.combat
{
   import flash.utils.Dictionary;
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.view.ui.mainframe.combat.tooltip.MobileMercenaryDeployTabBeastView;
   
   public class MobileMercenaryDeployTab extends MobileBaseBottomMainframePanel implements View
   {
      
      public function MobileMercenaryDeployTab()
      {
         super();
      }
      
      public function updateMercenaries(param1:Dictionary, param2:Vector.<UnitTypeDIO>, param3:BeastInfo, param4:BeastTypeDIO) : void
      {
         var _loc5_:MobileMercenaryDeployTabBeastView = null;
         var _loc7_:MobileMercenaryDeployTabMercenaryView = null;
         if(_views.length > 0)
         {
            return;
         }
         clearViews();
         if(param3)
         {
            _loc5_ = new MobileMercenaryDeployTabBeastView(param3,param4);
            _scrollPane.addChild(_loc5_);
            _views.push(_loc5_);
         }
         for each(var _loc6_ in param2)
         {
            _loc7_ = new MobileMercenaryDeployTabMercenaryView(_loc6_,_loc6_.id);
            _views.push(_loc7_);
            _scrollPane.addChild(_loc7_);
         }
         drawLayout();
      }
      
      public function get mercenaryViews() : Vector.<Sprite>
      {
         return _views;
      }
   }
}

