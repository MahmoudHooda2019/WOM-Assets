package wom.view.mediator.screen.windows.league.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.i18n.PText;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.model.game.league.LeagueManager;
   import wom.view.screen.windows.league.mobile.MobileLeagueGeneralInfoPanel;
   
   public class MobileLeagueGeneralInfoPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileLeagueGeneralInfoPanel;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileLeagueGeneralInfoPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("leagueStatusUpdated",onLeagueStatusUpdated,ModelUpdateEvent);
         updateLeagueLevels();
         leagueStatusUpdated();
      }
      
      private function leagueStatusUpdated() : void
      {
         var _loc2_:LeagueLevelDIO = null;
         var _loc1_:* = undefined;
         var _loc3_:Number = NaN;
         if(leagueManager.myLeague != null)
         {
            if(leagueManager.myLeague.levelDIO.id == 16)
            {
               view.toggleRewardPanel(false);
            }
            else
            {
               _loc3_ = leagueManager.myLeague.levelDIO.id + 1;
            }
         }
         else
         {
            _loc3_ = 1;
         }
         if(!isNaN(_loc3_))
         {
            _loc2_ = domainInfo.getLeagueLevel(_loc3_);
            _loc1_ = new Vector.<LeagueBonusAndRewardDTO>();
            var _temp_5:* = _loc1_;
            var _temp_4:* = §§findproperty(LeagueBonusAndRewardDTO);
            var _temp_3:* = "ResourceIconIron";
            var _temp_2:* = null;
            var _temp_1:* = "ui.windows.league.bonus.percentage";
            var _loc4_:int = _loc2_.ironProductionBonusPercentage;
            var _loc5_:String = _temp_1;
            _temp_5.push(new LeagueBonusAndRewardDTO(_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_)));
            view.updateBonusAndRewardPanel(_loc1_);
         }
      }
      
      private function onLeagueStatusUpdated(param1:ModelUpdateEvent) : void
      {
         leagueStatusUpdated();
      }
      
      private function updateLeagueLevels() : void
      {
         var _loc1_:Vector.<LeagueLevelDIO> = new Vector.<LeagueLevelDIO>();
         for each(var _loc2_ in domainInfo.getLeagueLevels())
         {
            if(_loc2_.division == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         view.updateLeagueLevels(_loc1_);
      }
   }
}

