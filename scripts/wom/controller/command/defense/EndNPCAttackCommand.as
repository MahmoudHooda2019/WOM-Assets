package wom.controller.command.defense
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.defense.EndNPCAttackEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.dto.combat.BuildingHealth;
   import wom.model.dto.combat.DefenderBuildingInfo;
   import wom.model.dto.combat.PostBattleDefenderInfo;
   import wom.model.dto.combat.PostNPCBattleInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.WomScreenType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.request.EndNPCAttackRequest;
   import wom.model.message.request.StatusRequest;
   
   public class EndNPCAttackCommand extends PCommand
   {
      
      [Inject]
      public var event:EndNPCAttackEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function EndNPCAttackCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:Building = null;
         var _loc10_:int = 0;
         var _loc9_:Vector.<DefenderBuildingInfo> = new Vector.<DefenderBuildingInfo>();
         attackInfo.attackEnded = true;
         var _loc12_:Vector.<BuildingHealth> = new Vector.<BuildingHealth>();
         for each(var _loc5_ in city.buildings)
         {
            _loc12_.push(new BuildingHealth(_loc5_.instanceId,_loc5_.healthPoint));
            _loc3_ = gameRootHolder.gameRoot.buildings[_loc5_.instanceId];
            if(_loc3_)
            {
               _loc9_.push(_loc3_.data.createLog());
            }
         }
         var _loc8_:Dictionary = new Dictionary();
         for each(var _loc2_ in attackInfo.units)
         {
            if(_loc2_.status == UnitStatusType.ATTACKING || _loc2_.status == UnitStatusType.DEAD)
            {
               if(!(_loc2_.typeId in _loc8_))
               {
                  _loc8_[_loc2_.typeId] = 0;
               }
               _loc8_[_loc2_.typeId]++;
            }
         }
         var _loc7_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         for(var _loc4_ in _loc8_)
         {
            _loc7_.push(new UnitTypeAmountDTO(int(_loc4_),_loc8_[_loc4_]));
         }
         var _loc11_:Dictionary = new Dictionary();
         var _loc1_:Dictionary = new Dictionary();
         var _loc6_:Dictionary = new Dictionary();
         for each(_loc2_ in city.units)
         {
            if(_loc2_.status == UnitStatusType.DEAD)
            {
               _loc10_ = 0;
               for each(_loc5_ in city.buildings)
               {
                  if(_loc5_.instanceId == _loc2_.buildingId)
                  {
                     _loc10_ = _loc5_.buildingTypeId;
                     break;
                  }
               }
               if(_loc10_ == 19)
               {
                  if(!(_loc2_.typeId in _loc1_))
                  {
                     _loc1_[_loc2_.typeId] = 0;
                  }
                  _loc1_[_loc2_.typeId]++;
               }
               else if(_loc10_ == 37)
               {
                  if(!(_loc2_.buildingId in _loc11_))
                  {
                     _loc11_[_loc2_.buildingId] = new Dictionary();
                  }
                  if(!(_loc2_.typeId in _loc11_[_loc2_.buildingId]))
                  {
                     _loc11_[_loc2_.buildingId][_loc2_.typeId] = 0;
                  }
                  _loc11_[_loc2_.buildingId][_loc2_.typeId]++;
               }
               else if(_loc10_ == 38)
               {
                  if(!(_loc2_.typeId in _loc6_))
                  {
                     _loc6_[_loc2_.typeId] = 0;
                  }
                  _loc6_[_loc2_.typeId]++;
               }
            }
         }
         userInfo.repairPopupShown = false;
         dispatch(new OutgoingMessageEvent("outgoingMessage",new EndNPCAttackRequest(new PostNPCBattleInfo(new PostBattleDefenderInfo(attackInfo.defender,_loc12_,attackInfo.usedTrapInstanceIds,city.beast ? city.beast.healthPoints : -1,_loc11_,_loc1_,_loc6_,_loc9_,attackInfo.totalCatapultDamageDone,10),attackInfo.lootedHarvestedResources,attackInfo.lootedUnharvestedResources))));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StatusRequest()));
      }
   }
}

