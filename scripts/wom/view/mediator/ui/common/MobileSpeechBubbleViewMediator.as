package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileSpeechBubbleViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileSpeechBubbleView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileSpeechBubbleViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
      }
   }
}

