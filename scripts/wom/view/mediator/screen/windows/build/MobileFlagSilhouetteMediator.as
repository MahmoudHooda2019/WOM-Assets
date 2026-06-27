package wom.view.mediator.screen.windows.build
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.game.CityStatusInfo;
   import wom.view.screen.windows.build.MobileFlagSilhouette;
   
   public class MobileFlagSilhouetteMediator extends StarlingMediator
   {
      
      private static const EMPTY_ALLIANCE_FLAG:String = "16777215x16777215x0";
      
      [Inject]
      public var view:MobileFlagSilhouette;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      public function MobileFlagSilhouetteMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         view.allianceId = cityInfo.ownerAlliance ? cityInfo.ownerAlliance.coaInfo.patternColorA.color + "x" + cityInfo.ownerAlliance.coaInfo.patternColorB.color + "x" + cityInfo.ownerAlliance.coaInfo.patternId : "16777215x16777215x0";
         injector.injectInto(view);
      }
   }
}

