package wom.controller.command.tuskhorn
{
   import peak.logging.log;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.message.response.StartTuskHornAttackResponse;
   import wom.service.logging.WomLoggerContexts;
   
   public class HandleStartTuskHornAttackResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function HandleStartTuskHornAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:StartTuskHornAttackResponse = messageReceivedEvent.message as StartTuskHornAttackResponse;
         if(_loc1_.resultCode == 0)
         {
            gameRootHolder.gameRoot.exitBuildMode();
            gameRootHolder.gameRoot.cancelMove();
            dispatch(new PopUpWindowEvent("delayPopUps",null));
            coreManager.closeBuildingTooltip();
            coreManager.prepareNPCAttack();
            userInfo.gameMode = GameModeType.TUSK_HORN;
            dispatch(new GameModeChangedEvent("gameModeChange"));
            dispatch(new ModelUpdateEvent("resourcesUpdated"));
            soundPlayer.stopAmbient();
            soundPlayer.playMusicById("DefenseTheme");
            coreManager.startBattle();
         }
         else
         {
            log(WomLoggerContexts.GAME,"NPC Attack Failed : " + _loc1_.resultMessage);
         }
      }
   }
}

