package peak.cuckoo.game.attribute.bounds
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.behavior.render.gpu.GpuImage;
   import peak.cuckoo.game.dto.Point3;
   
   public class RenderBounds extends Attribute
   {
      
      public static const TYPE_ID:String = "RenderBounds";
      
      public var point:Point;
      
      public var right:Number;
      
      public var bottom:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var baseWidth:Number;
      
      public var baseHeight:Number;
      
      protected var projected:Point3;
      
      protected var rect:Rectangle;
      
      protected var gpuImage:GpuImage;
      
      public function RenderBounds(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.point = new Point();
         this.height = param1;
         this.width = param2;
      }
      
      override public function get typeId() : String
      {
         return "RenderBounds";
      }
      
      override public function init() : void
      {
         var _loc1_:GameSprite = owner as GameSprite;
         projected = _loc1_.position.projected;
         rect = owner.root.viewport.rect;
         var _loc2_:BaseView = (owner as GameSprite).view as BaseView;
         if(_loc2_)
         {
            this.baseWidth = this.width = _loc2_.width;
            this.baseHeight = this.height = _loc2_.height;
            gpuImage = _loc2_.gpuImage;
         }
         update();
      }
      
      public function update() : void
      {
         point.x = projected.x - rect.x;
         point.y = projected.y - rect.y;
         right = point.x + baseWidth;
         bottom = point.y + baseHeight;
         if(gpuImage)
         {
            gpuImage.updateCoords(true);
         }
      }
   }
}

