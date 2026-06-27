package wom.view.mediator.screen.windows
{
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.MobileWebViewWindow;
   
   public class MobileWebViewWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileWebViewWindow;
      
      public function MobileWebViewWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
      }
      
      override public function onRemove() : void
      {
         if(view && view.webView)
         {
            view.webView.dispose();
         }
         super.onRemove();
      }
   }
}

