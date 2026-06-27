package wom.view.mediator.screen.windows.staff
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.domain.DomainInfo;
   import wom.view.screen.windows.staff.MobileRequiredStaffsPanel;
   
   public class MobileRequiredStaffsPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileRequiredStaffsPanel;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileRequiredStaffsPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
      }
   }
}

