package wom.view.mediator.screen.popups.npcattack
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.model.domain.DomainInfo;
   import wom.view.screen.popups.npcattack.MobileNPCAttackPopupBatchView;
   
   public class MobileNPCAttackPopupBatchViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileNPCAttackPopupBatchView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileNPCAttackPopupBatchViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.unitTypeDIO = domainInfo.getUnit(view.unitInformation.id);
         injector.injectInto(view);
      }
   }
}

