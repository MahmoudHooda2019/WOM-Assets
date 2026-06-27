package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.model.component.CuckooNotifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.dto.DeployedCatapultCircleInfoDTO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.dto.combat.CatapultInfo;
   
   public class CatapultManager2 extends Attribute
   {
      
      private var battleManager:BattleManager;
      
      private var womRoot:WomGameRoot;
      
      private var activeCatapults:Vector.<Entity>;
      
      private var catapultDIO:Dictionary;
      
      public var currentInfo:CatapultInfo;
      
      public var currentDIO:CatapultTypeDIO;
      
      public var currentCatapultPlan:Entity;
      
      public function CatapultManager2(param1:BattleManager)
      {
         super();
         this.battleManager = param1;
         activeCatapults = new Vector.<Entity>();
         this.womRoot = param1.owner as WomGameRoot;
         this.catapultDIO = womRoot.domainInfo.getCatapults();
      }
      
      public function startCatapultPlan(param1:int, param2:int) : Entity
      {
         currentInfo = new CatapultInfo(param1,param2);
         currentDIO = catapultDIO[param1];
         currentCatapultPlan = new Entity();
         switch(currentInfo.type - 1)
         {
            case 0:
               currentCatapultPlan.componentManager.add(new LumberSalvoCatapult(battleManager,currentInfo));
               break;
            case 1:
               currentCatapultPlan.componentManager.add(new HurlingStonesCatapult(battleManager,currentInfo));
               break;
            case 2:
               currentCatapultPlan.componentManager.add(new MightyRageCatapult(battleManager,currentInfo));
               break;
            case 3:
               currentCatapultPlan.componentManager.add(new AcidRainCatapult(battleManager,currentInfo));
               break;
            case 4:
               currentCatapultPlan.componentManager.add(new IceShardCatapult(battleManager,currentInfo));
               break;
            case 5:
               currentCatapultPlan.componentManager.add(new HealAuraCatapult(battleManager,currentInfo));
         }
         womRoot.addChild(currentCatapultPlan);
         currentCatapultPlan.init();
         return currentCatapultPlan;
      }
      
      public function removeCurrentCatapultPlan() : void
      {
         currentCatapultPlan = null;
         currentInfo = null;
      }
      
      public function deployCatapult(param1:Point) : void
      {
         activeCatapults.push(currentCatapultPlan);
         (currentCatapultPlan.componentManager["BaseCatapult"] as BaseCatapult).deployCatapult(param1);
         var _loc2_:Array = [];
         var _loc3_:CatapultTypeDIO = catapultDIO[currentInfo.type] as CatapultTypeDIO;
         womRoot.attackInfo.salvosUsed[currentInfo.type] = true;
         if(_loc3_.resourceCosts.length > 0)
         {
            for each(var _loc4_ in _loc3_.resourceCosts[currentInfo.size])
            {
               _loc2_[_loc4_.resourceType] = _loc4_.resourceAmount;
               womRoot.attackInfo.attackingUserResources[_loc4_.resourceType] -= _loc4_.resourceAmount;
            }
         }
         CuckooNotifier.getInstance().catapultDeployedDTO(new DeployedCatapultCircleInfoDTO(FpsSync.frameNum,new Point3(param1.x,param1.y),currentInfo.size,currentInfo.type));
         if(currentInfo.type == 4 || currentInfo.type == 5 || currentInfo.type == 6)
         {
            womRoot.eventDispatcher.dispatchEvent(new CombatEventItemsEvent("itemDeployed",currentInfo.type));
         }
         womRoot.eventDispatcher.dispatchEvent(new ModelUpdateEvent("attackInfoUpdated"));
      }
      
      public function removeActiveCatapult(param1:Entity) : void
      {
         activeCatapults.splice(activeCatapults.indexOf(param1),1);
         battleManager.owner.removeChild(param1);
         param1.destroy();
      }
   }
}

