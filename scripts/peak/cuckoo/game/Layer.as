package peak.cuckoo.game
{
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.attribute.container.GameSpriteContainer;
   import peak.cuckoo.game.attribute.container.RenderChildrenContainer;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.behavior.cull.BaseCull;
   import peak.cuckoo.game.behavior.sort.BaseSort;
   
   public class Layer extends Entity
   {
      
      public static const BACKGROUND_LAYER:int = 0;
      
      public static const TILE_LAYER:int = 1;
      
      public static const FLOOR_LAYER:int = 2;
      
      public static const MAIN_LAYER:int = 3;
      
      public static const AIR_LAYER:int = 4;
      
      public var allChildrenContainer:GameSpriteContainer;
      
      public var renderChildrenContainer:RenderChildrenContainer;
      
      public var projection:BaseProjection;
      
      public var sort:BaseSort;
      
      public var cull:BaseCull;
      
      public var type:int;
      
      public function Layer(param1:int)
      {
         super();
         this.type = param1;
         componentManager.add(renderChildrenContainer = new RenderChildrenContainer());
         componentManager.add(allChildrenContainer = new GameSpriteContainer());
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      public function add(param1:GameSprite) : void
      {
         if(allChildrenContainer.children.indexOf(param1) != -1)
         {
            return;
         }
         allChildrenContainer.children.push(param1);
         renderChildrenContainer.renderChildren.push(param1);
         if(param1.view)
         {
            param1.view.layerId = type;
         }
      }
      
      public function remove(param1:GameSprite) : void
      {
         var _loc2_:int = allChildrenContainer.children.lastIndexOf(param1);
         if(_loc2_ != -1)
         {
            allChildrenContainer.children.splice(_loc2_,1);
         }
         var _loc3_:int = renderChildrenContainer.renderChildren.lastIndexOf(param1);
         if(_loc3_ != -1)
         {
            renderChildrenContainer.renderChildren.splice(_loc3_,1);
         }
      }
      
      override public function destroyAll() : void
      {
         renderChildrenContainer.removeAll();
         allChildrenContainer.removeAll();
         super.destroyAll();
      }
   }
}

