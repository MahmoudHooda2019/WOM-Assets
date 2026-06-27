package wom.view.mediator.util
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileBaseWindowPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var mobileBaseWindowPanelView:MobileBaseWindowPanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileBaseWindowPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(mobileBaseWindowPanelView);
      }
   }
}

