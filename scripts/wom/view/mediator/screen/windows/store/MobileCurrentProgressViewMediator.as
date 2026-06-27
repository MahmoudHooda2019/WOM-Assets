package wom.view.mediator.screen.windows.store
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.view.screen.windows.store.MobileCurrentProgressView;
   
   public class MobileCurrentProgressViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCurrentProgressView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileCurrentProgressViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("goldAmountUpdated",updateProgress,ModelUpdateEvent);
         addContextListener("reconPoinrsUpdated",updateProgress,ModelUpdateEvent);
         if(view.isGold)
         {
            view.update(userInfo.numberOfGolds);
         }
         else
         {
            view.update(userInfo.reconPoints);
         }
      }
      
      private function updateProgress(param1:ModelUpdateEvent) : void
      {
         if(view.isGold)
         {
            view.update(userInfo.numberOfGolds);
         }
         else
         {
            view.update(userInfo.reconPoints);
         }
      }
   }
}

