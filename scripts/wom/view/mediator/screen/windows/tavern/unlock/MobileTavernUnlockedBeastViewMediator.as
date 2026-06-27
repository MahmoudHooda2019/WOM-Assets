package wom.view.mediator.screen.windows.tavern.unlock
{
   import wom.model.domain.DomainInfo;
   import wom.view.screen.windows.tavern.unlock.MobileTavernUnlockedBeastView;
   
   public class MobileTavernUnlockedBeastViewMediator extends MobileBaseTavernUnlockedCardViewMediator
   {
      
      [Inject]
      public var view:MobileTavernUnlockedBeastView;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileTavernUnlockedBeastViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.update(domainInfo.getBeast(33));
      }
   }
}

