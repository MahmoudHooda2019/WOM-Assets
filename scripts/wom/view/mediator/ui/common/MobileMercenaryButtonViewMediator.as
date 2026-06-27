package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.game.CityStatusInfo;
   import wom.view.ui.common.MobileMercenaryButtonView;
   
   public class MobileMercenaryButtonViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var mercView:MobileMercenaryButtonView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileMercenaryButtonViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         if(mercView.unitTypeDIO)
         {
            mercView.unitTypeInfo = city.unitTypes[mercView.unitTypeDIO.id];
         }
         injector.injectInto(mercView);
      }
   }
}

