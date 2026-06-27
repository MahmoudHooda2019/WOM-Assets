package wom.controller.command.defense
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.defense.SoundTuskHornEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.StartTuskHornAttackRequest;
   
   public class SoundTuskHornCommand extends PCommand
   {
      
      [Inject]
      public var event:SoundTuskHornEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      public function SoundTuskHornCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:UnitTypeDIO = null;
         var _loc3_:UnitTypeInfo = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:UnitStatusType = null;
         attackInfo.reset();
         attackInfo.unitTypes = new Dictionary();
         attackInfo.units = new Vector.<UnitInfo>();
         attackInfo.attackStartTime = getTimer();
         attackInfo.attackEndTime = attackInfo.attackStartTime + 420000;
         attackInfo.attackEndTimeExtended = false;
         attackInfo.defender = userInfo.profile;
         attackInfo.attacker = userInfo.profile;
         attackInfo.isAttackOngoing = true;
         attackInfo.eventItemCounts = new Dictionary();
         attackInfo.attackingUserResources = [];
         attackInfo.beast = null;
         attackInfo.combatItemEffects = new Vector.<ItemEffectInfo>();
         attackInfo.mostNeededPartId = -1;
         for each(var _loc4_ in event.units)
         {
            _loc2_ = domainInfo.getUnit(_loc4_.id);
            if(!(_loc4_.id in cityInfo.unitTypes))
            {
               _loc3_ = attackInfo.unitTypes[_loc4_.id] = new UnitTypeInfo(_loc4_.id,1,true,false,false,false,false,0,0,0);
            }
            else
            {
               _loc3_ = attackInfo.unitTypes[_loc4_.id] = cityInfo.unitTypes[_loc4_.id];
            }
            _loc5_ = _loc3_.currentLevel - 1;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.amount)
            {
               _loc1_ = UnitStatusType.WAITING_TO_DEPLOY;
               attackInfo.units.push(new UnitInfo(DefaultUnitFactory.generateUnitId(),_loc1_,-1,_loc4_.id,_loc2_.healthPointsPerLevel[_loc5_],1,1,1));
               _loc6_++;
            }
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StartTuskHornAttackRequest()));
      }
   }
}

