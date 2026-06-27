package wom.view.screen
{
   import wom.model.game.CityStatusInfo;
   import wom.model.resource.WomAssetRepository;
   
   public class MobileCityPlannerScreen extends MobileBaseScreen
   {
      
      public static const MARGIN:int = 0;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public function MobileCityPlannerScreen()
      {
         super();
      }
      
      [PostConstruct]
      public function postConstruct() : void
      {
      }
   }
}

