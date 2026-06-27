package wom.controller.command.unit
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.unit.ChooseAttackingSoldierEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class ChooseAttackingSoldierEventCommand extends PCommand
   {
      
      [Inject]
      public var event:ChooseAttackingSoldierEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function ChooseAttackingSoldierEventCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         try
         {
            _loc4_ = 0;
            if(event.select && attackInfo.beast && attackInfo.beast.status == UnitStatusType.DEPLOYING)
            {
               attackInfo.beast.status = UnitStatusType.WAITING_TO_DEPLOY;
            }
            for each(var _loc1_ in attackInfo.units)
            {
               if(_loc1_.status == UnitStatusType.DEPLOYING)
               {
                  _loc1_.status = UnitStatusType.WAITING_TO_DEPLOY;
               }
            }
            _loc3_ = !event.select;
            if(event.select)
            {
               for each(_loc1_ in attackInfo.units)
               {
                  if(event.unitTypeId == _loc1_.typeId && (event.select ? _loc1_.status == UnitStatusType.WAITING_TO_DEPLOY : _loc1_.status == UnitStatusType.DEPLOYING))
                  {
                     _loc3_ = true;
                     _loc1_.status = event.select ? UnitStatusType.DEPLOYING : UnitStatusType.WAITING_TO_DEPLOY;
                     _loc4_ += (event.select ? 1 : -1) * domainInfo.getUnit(_loc1_.typeId).spacesPerLevel[(attackInfo.unitTypes[_loc1_.typeId] as UnitTypeInfo).currentLevel - 1];
                     if(!event.inTutorial)
                     {
                        break;
                     }
                  }
               }
            }
            if(_loc3_)
            {
               _loc2_ = int(_loc4_ == 0 && (!attackInfo.beast || attackInfo.beast && attackInfo.beast.status != UnitStatusType.DEPLOYING) ? 0 : 24);
               dispatch(new ModelUpdateEvent("attackingUnitUpdated"));
               coreManager.setDeployDiameter(_loc2_,1);
            }
            dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
         }
         catch(e:Error)
         {
            log(LoggerContexts.UNEXPECTED,"ChooseAttackingSoldierEventCommand Error ");
            e.getStackTrace();
         }
      }
   }
}

