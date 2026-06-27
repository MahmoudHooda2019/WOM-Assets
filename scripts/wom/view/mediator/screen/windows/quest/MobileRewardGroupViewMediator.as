package wom.view.mediator.screen.windows.quest
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.screen.windows.quest.MobileRewardGroupView;
   
   public class MobileRewardGroupViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileRewardGroupView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileRewardGroupViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
      }
   }
}

