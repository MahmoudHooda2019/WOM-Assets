package wom.model.component.entity.gamesprite
{
   import peak.cuckoo.game.GameSprite;
   
   public class Doodad extends GameSprite
   {
      
      public var assetId:int;
      
      public var zIndex:int = 0;
      
      public function Doodad()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

