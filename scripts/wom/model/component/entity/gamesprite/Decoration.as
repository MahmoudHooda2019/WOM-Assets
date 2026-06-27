package wom.model.component.entity.gamesprite
{
   import peak.cuckoo.game.GameSprite;
   import wom.model.component.attribute.data.DecorationData;
   import wom.model.component.attribute.viewManager.DecorationViewManager;
   
   public class Decoration extends GameSprite
   {
      
      public var viewManager:DecorationViewManager;
      
      public var data:DecorationData;
      
      public function Decoration()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         viewManager = null;
         data = null;
      }
   }
}

