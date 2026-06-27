package wom.view.mediator.screen.windows.build
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.domain.DomainInfo;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   
   public class MobileBuildingSilhouetteMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingSilhouette;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileBuildingSilhouetteMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         view.buildingTypeDIO = domainInfo.getBuilding(view.buildingTypeId);
         injector.injectInto(view);
      }
   }
}

