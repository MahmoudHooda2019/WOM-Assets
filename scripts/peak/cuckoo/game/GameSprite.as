package peak.cuckoo.game
{
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.attribute.filter.FilterManager;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.behavior.Validator;
   
   public class GameSprite extends Entity
   {
      
      public var interactive:Boolean;
      
      public var culled:Boolean;
      
      public var filter:int;
      
      public var composite:GameSprite;
      
      public var position:Position;
      
      public var view:BaseView;
      
      public var bounds:RenderBounds;
      
      public var validator:Validator;
      
      public var filterManager:FilterManager;
      
      public var nextInvalidated:GameSprite;
      
      public function GameSprite()
      {
         super();
         componentManager.add(bounds = new RenderBounds());
         componentManager.add(filterManager = new FilterManager());
      }
      
      override public function init() : void
      {
         validator = root.validator;
         this.validator.add(this);
         super.init();
      }
      
      override public function addChild(param1:Entity) : void
      {
         super.addChild(param1);
      }
      
      final public function invalidate() : void
      {
         validator.add(this);
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         if(composite && composite == this)
         {
            _loc1_ = children.length - 1;
            while(_loc1_ >= 0)
            {
               children[_loc1_].destroy();
               _loc1_--;
            }
            children.length = 0;
         }
         super.destroy();
         position = null;
         view = null;
         bounds = null;
         composite = null;
         validator = null;
      }
   }
}

