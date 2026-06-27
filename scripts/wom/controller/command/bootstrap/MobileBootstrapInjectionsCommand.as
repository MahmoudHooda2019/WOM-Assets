package wom.controller.command.bootstrap
{
   import flash.display.LoaderInfo;
   import peak.config.DocumentConfiguration;
   import peak.i18n.PText;
   import peak.logging.ExternalShippingLoggerTarget;
   import peak.logging.Logger;
   import peak.logging.ShippingLoggerTarget;
   import peak.messaging.DataToMessageContainerConverter;
   import peak.messaging.MessageContainerToDataConverter;
   import peak.messaging.json.JsonStringToMessageContainerConverterUsingIncomingMessageMap;
   import peak.messaging.json.MessageContainerToJsonStringConverter;
   import peak.network.NullTerminatedCipheredUtfSocketConnection;
   import peak.network.ServerConnection;
   import peak.network.XORCipher;
   import peak.resource.AssetRepository;
   import peak.resource.DefaultSoundPlayer;
   import peak.resource.SoundPlayer;
   import peak.task.TaskQueue;
   import wom.Environment;
   import wom.ane.velocity.VelocityController;
   import wom.controller.PCommand;
   import wom.controller.command.util.SwearFilter;
   import wom.model.GameTickTimer;
   import wom.model.component.CoreManager;
   import wom.model.component.CuckooNotifier;
   import wom.model.component.DefaultCoreManager;
   import wom.model.component.WomCampaignRoot;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.component.factory.ConstructableFactory;
   import wom.model.component.factory.DefaultConstructableFactory;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.component.factory.UnitFactory;
   import wom.model.configuration.WebDocumentConfiguration;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.JsonPopulatedDomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.CampaignMapInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.DefaultAttackInfo;
   import wom.model.game.DefaultCityStatusInfo;
   import wom.model.game.DefaultUserInfo;
   import wom.model.game.DefaultVisitInfo;
   import wom.model.game.DeployedUnitsStatusInfo;
   import wom.model.game.MobileMapInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.UserInterfaceInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WaypointStatusInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.event.EventItemUtil2;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.gold.GoldCostConstants;
   import wom.model.game.gold.PaymentInfo;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.tavern.TavernInfo;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.model.resource.MobileWomDefaultAssetRepository;
   import wom.model.resource.WomAssetRepository;
   import wom.model.resource.WomDefaultAssetRepository;
   import wom.service.RetrieveDevelopersService;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.kontagent.WomKontagentApi;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.service.mobile.MobileAlertDialogsManager;
   import wom.service.mobile.MobileApplicationRaterService;
   import wom.service.mobile.MobileApplicationStatusManager;
   import wom.service.mobile.MobileConnectionService;
   import wom.service.mobile.MobileExternalPages;
   import wom.service.mobile.MobileGooglePlayGamesServicesManager;
   import wom.service.mobile.MobileInAppPurchaseService;
   import wom.service.mobile.MobileNetworkInfoService;
   import wom.service.mobile.MobilePushNotificationsService;
   import wom.service.network.ChatNullTerminatedCipheredUtfSocketConnection;
   
   public class MobileBootstrapInjectionsCommand extends PCommand
   {
      
      public function MobileBootstrapInjectionsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc8_:WomDocumentConfiguration = null;
         var _loc3_:ShippingLoggerTarget = null;
         injector.mapValue(LoaderInfo,Environment.loaderInfo);
         _loc8_ = injector.instantiate(WebDocumentConfiguration);
         injector.mapValue(DocumentConfiguration,_loc8_);
         injector.mapValue(WomDocumentConfiguration,_loc8_);
         injector.mapValue(Logger,Logger.INSTANCE);
         injector.mapValue(PText,PText.INSTANCE);
         injector.mapValue(TaskQueue,TaskQueue._instance);
         injector.mapSingleton(WomKontagentApi);
         if(_loc8_.hasParameter("shipper_type") && _loc8_.getParameter("shipper_type") == "new")
         {
            _loc3_ = new ExternalShippingLoggerTarget(40,10000);
         }
         else
         {
            _loc3_ = new ShippingLoggerTarget(400,64000);
         }
         injector.injectInto(_loc3_);
         injector.mapValue(ShippingLoggerTarget,_loc3_);
         var _loc4_:NullTerminatedCipheredUtfSocketConnection = new NullTerminatedCipheredUtfSocketConnection(new XORCipher("if (reg==true)","// TODO"),"Server: ");
         var _loc7_:ChatNullTerminatedCipheredUtfSocketConnection = new ChatNullTerminatedCipheredUtfSocketConnection(new XORCipher("if (reg==true)","// TODO"),"Chat: ");
         injector.injectInto(_loc4_);
         injector.injectInto(_loc7_);
         injector.mapValue(ServerConnection,_loc4_,"gameServer");
         injector.mapValue(ServerConnection,_loc7_,"chatServer");
         injector.mapSingletonOf(DataToMessageContainerConverter,JsonStringToMessageContainerConverterUsingIncomingMessageMap);
         injector.mapSingletonOf(MessageContainerToDataConverter,MessageContainerToJsonStringConverter);
         injector.mapSingleton(GameTickTimer);
         injector.mapSingletonOf(UserInfo,DefaultUserInfo);
         injector.mapSingleton(UserInterfaceInfo);
         injector.mapSingletonOf(DomainInfo,JsonPopulatedDomainInfo);
         injector.mapSingleton(ErrorCodeRepository);
         injector.mapSingleton(PaymentInfo);
         injector.mapSingleton(AllianceInfo);
         injector.mapSingleton(CampaignMapInfo);
         injector.mapSingleton(MobileMapInfo);
         injector.mapSingleton(InboxInfo);
         injector.mapSingleton(LeagueManager);
         injector.mapSingleton(StoreInfo);
         injector.mapSingleton(TavernInfo);
         var _loc1_:WomAssetRepository = injector.instantiate(WomDefaultAssetRepository);
         injector.mapValue(WomAssetRepository,_loc1_);
         injector.mapValue(AssetRepository,_loc1_);
         injector.mapSingletonOf(SoundPlayer,DefaultSoundPlayer);
         injector.mapSingleton(WomGameRootHolder);
         injector.mapSingleton(CuckooNotifier);
         injector.mapSingleton(WomPlannerRootV2);
         injector.mapSingleton(WomCampaignRoot);
         injector.mapSingletonOf(CityStatusInfo,DefaultCityStatusInfo);
         injector.mapSingletonOf(AttackInfo,DefaultAttackInfo);
         injector.mapSingletonOf(VisitInfo,DefaultVisitInfo);
         injector.mapSingletonOf(ConstructableFactory,DefaultConstructableFactory);
         injector.mapSingletonOf(UnitFactory,DefaultUnitFactory);
         injector.mapSingletonOf(CoreManager,DefaultCoreManager);
         injector.mapSingleton(FacebookAPIManager);
         injector.mapSingleton(RetrieveDevelopersService);
         injector.mapSingleton(GoldCostConstants);
         injector.mapSingleton(WaypointStatusInfo);
         injector.mapSingleton(DeployedUnitsStatusInfo);
         injector.mapSingleton(SwearFilter);
         var _loc5_:MobileWomAssetRepository = new MobileWomDefaultAssetRepository(_loc8_);
         injector.mapValue(MobileWomAssetRepository,_loc5_);
         injector.mapSingleton(VelocityController);
         injector.mapSingleton(MobilePushNotificationsService);
         injector.mapSingleton(MobileInAppPurchaseService);
         injector.mapSingleton(MobileConnectionService);
         injector.mapSingleton(MobileExternalPages);
         injector.mapSingleton(MobileApplicationRaterService);
         injector.mapSingleton(MobileConnectionServiceInfo);
         injector.mapSingleton(MobileNetworkInfoService);
         injector.mapSingleton(MobileGooglePlayGamesServicesManager);
         var _loc6_:MobileApplicationStatusManager = injector.instantiate(MobileApplicationStatusManager);
         injector.mapValue(MobileApplicationStatusManager,_loc6_);
         var _loc2_:MobileAlertDialogsManager = injector.instantiate(MobileAlertDialogsManager);
         injector.mapValue(MobileAlertDialogsManager,_loc2_);
         injector.mapSingleton(EventItemUtil2);
      }
   }
}

