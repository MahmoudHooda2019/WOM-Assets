package peak.cuckoo.game.attribute
{
   import flash.geom.Rectangle;
   import peak.cuckoo.core.Attribute;
   
   public class Viewport extends Attribute
   {
      
      public static const TYPE_ID:String = "Viewport";
      
      public var rect:Rectangle;
      
      public var bounds:Rectangle;
      
      public function Viewport(param1:Rectangle)
      {
         super();
         this.rect = new Rectangle();
         this.bounds = param1;
      }
      
      override public function get typeId() : String
      {
         return "Viewport";
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         rect.x = param1 < bounds.x ? bounds.x : (param1 + rect.width > bounds.x + bounds.width ? bounds.x + bounds.width - rect.width : param1);
         rect.y = param2 < bounds.y ? bounds.y : (param2 + rect.height > bounds.y + bounds.height ? bounds.y + bounds.height - rect.height : param2);
         owner.root.validator.allInvalidated = true;
         var _loc3_:BaseRender = owner.root.render;
         _loc3_.invalidated |= 2;
         _loc3_.arrangeCanvasAndViewport();
         _loc3_.invalidated = 0;
         undefined;
      }
      
      public function center() : void
      {
         moveTo(bounds.x + (bounds.width - rect.width >> 1),bounds.y + (bounds.height - rect.height >> 1));
      }
      
      public function centerTo(param1:Number, param2:Number) : void
      {
         moveTo(param1 - rect.width / 2,param2 - rect.height / 2);
      }
      
      final public function sanitize() : void
      {
         if(rect.x < bounds.x || rect.x + rect.width > bounds.x + bounds.width || rect.y < bounds.y || rect.y + rect.height > bounds.y + bounds.height)
         {
            moveTo(rect.x,rect.y);
         }
      }
   }
}

