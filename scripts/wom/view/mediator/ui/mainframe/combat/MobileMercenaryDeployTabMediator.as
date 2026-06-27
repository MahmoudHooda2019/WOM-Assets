package wom.view.mediator.ui.mainframe.combat
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import starling.display.Sprite;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.view.ui.mainframe.combat.MobileMercenaryDeployTab;
   import wom.view.ui.mainframe.combat.MobileMercenaryDeployTabMercenaryView;
   
   public class MobileMercenaryDeployTabMediator extends MobileBaseBottomMainframePanelMediator
   {
      
      [Inject]
      public var view:MobileMercenaryDeployTab;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileMercenaryDeployTabMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override protected function mapPanelSpecificListeners() : void
      {
         addContextListener("attackInfoUpdated",onAttackInfoUpdated);
         addContextListener("getCombatMercDeployTabMercViewPosition",onCombatMercDeployTabMercViewPositionRequested,TutorialReferencePositionEvent);
      }
      
      private function onAttackInfoUpdated(param1:ModelUpdateEvent) : void
      {
         updateViews();
      }
      
      override protected function updateViews() : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:* = undefined;
         if(attackInfo.deployPassed)
         {
            view.clearViews();
            view.visible = false;
         }
         else
         {
            _loc3_ = new Dictionary();
            _loc4_ = new Vector.<UnitTypeDIO>();
            for each(var _loc1_ in attackInfo.units)
            {
               if(!(_loc1_.typeId in _loc3_))
               {
                  _loc3_[_loc1_.typeId] = attackInfo.unitTypes[_loc1_.typeId];
               }
            }
            for each(var _loc2_ in domainInfo.getUnits())
            {
               if(_loc3_[_loc2_.id])
               {
                  _loc4_.push(_loc2_);
               }
            }
            if(attackInfo.beast)
            {
               view.updateMercenaries(_loc3_,_loc4_,attackInfo.beast,domainInfo.getBeast(attackInfo.beast.typeId));
            }
            else
            {
               view.updateMercenaries(_loc3_,_loc4_,null,null);
            }
         }
      }
      
      private function onCombatMercDeployTabMercViewPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:int = 0;
         if("unitTypeId" in param1.additionalInfo)
         {
            _loc2_ = int(param1.additionalInfo["unitTypeId"]);
            for each(var _loc3_ in view.mercenaryViews)
            {
               if(_loc3_ is MobileMercenaryDeployTabMercenaryView)
               {
                  if((_loc3_ as MobileMercenaryDeployTabMercenaryView).unitTypeId == _loc2_)
                  {
                     dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc3_.localToGlobal(new Point(0,0)),param1.additionalInfo,_loc3_));
                     break;
                  }
               }
            }
         }
      }
   }
}

