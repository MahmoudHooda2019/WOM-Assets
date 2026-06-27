package peak.cuckoo.game.attribute.container
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   
   public class RenderChildrenContainer extends Attribute
   {
      
      public static const TYPE_ID:String = "RenderChildrenContainer";
      
      public var renderChildren:Vector.<GameSprite>;
      
      public function RenderChildrenContainer()
      {
         super();
         this.renderChildren = new Vector.<GameSprite>();
      }
      
      override public function get typeId() : String
      {
         return "RenderChildrenContainer";
      }
      
      public function remove(param1:GameSprite) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < renderChildren.length)
         {
            if(renderChildren[_loc3_] == param1)
            {
               _loc2_ = true;
               renderChildren.splice(_loc3_,1);
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
         renderChildren.length = 0;
      }
      
      override public function disable() : void
      {
         removeAll();
      }
   }
}

