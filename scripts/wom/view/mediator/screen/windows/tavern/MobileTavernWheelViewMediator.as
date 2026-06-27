package wom.view.mediator.screen.windows.tavern
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.domain.DomainInfo;
   import wom.view.screen.windows.tavern.MobileTavernWheelView;
   
   public class MobileTavernWheelViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTavernWheelView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileTavernWheelViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.update(domainInfo.getTavernItems());
      }
   }
}

