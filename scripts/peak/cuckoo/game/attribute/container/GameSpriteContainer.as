package peak.cuckoo.game.attribute.container
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   
   public class GameSpriteContainer extends Attribute
   {
      
      public static const TYPE_ID:String = "GameSpriteContainer";
      
      public var children:Vector.<GameSprite>;
      
      public function GameSpriteContainer()
      {
         super();
         this.children = new Vector.<GameSprite>();
      }
      
      override public function get typeId() : String
      {
         return "GameSpriteContainer";
      }
      
      public function remove(param1:GameSprite) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < children.length)
         {
            if(children[_loc3_] == param1)
            {
               _loc2_ = true;
               children.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      override protected function stop() : void
      {
         super.stop();
         removeAll();
      }
      
      public function removeAll() : void
      {
         children.length = 0;
      }
      
      override public function disable() : void
      {
         removeAll();
      }
   }
}

