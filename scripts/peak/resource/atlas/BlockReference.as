package peak.resource.atlas
{
   import flash.display.BitmapData;
   import peak.cuckoo.game.behavior.render.gpu.GpuImage;
   import peak.resource.atlas.native.NativeAtlas;
   
   public class BlockReference
   {
      
      public var placed:Boolean = false;
      
      public var atlas:NativeAtlas;
      
      public var bitmapData:BitmapData;
      
      public var gpuImages:Vector.<GpuImage>;
      
      public var map:Vector.<Number>;
      
      public var x:int;
      
      public var y:int;
      
      public var h:int;
      
      public var w:int;
      
      public var hReal:int;
      
      public var wReal:int;
      
      public function BlockReference(param1:BitmapData, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         this.gpuImages = new Vector.<GpuImage>();
         this.bitmapData = param1;
         this.x = param2;
         this.y = param3;
         this.hReal = param5;
         this.wReal = param4;
         this.h = param5 + 1 * 2;
         this.w = param4 + 1 * 2;
         this.map = new Vector.<Number>(8,true);
      }
      
      public function addGpuImageUser(param1:GpuImage) : void
      {
         if(gpuImages.indexOf(param1) == -1)
         {
            gpuImages.push(param1);
         }
      }
      
      public function removeGpuImageUser(param1:GpuImage) : void
      {
         gpuImages.splice(gpuImages.indexOf(param1),1);
      }
      
      public function place(param1:NativeAtlas, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc7_:int = 0;
         var _loc6_:GpuImage = null;
         placed = true;
         this.atlas = param1;
         this.map[0] = param2;
         this.map[1] = param5;
         this.map[2] = param2;
         this.map[3] = param4;
         this.map[4] = param3;
         this.map[5] = param5;
         this.map[6] = param3;
         this.map[7] = param4;
         _loc7_ = gpuImages.length - 1;
         while(_loc7_ >= 0)
         {
            _loc6_ = gpuImages[_loc7_];
            _loc7_--;
         }
      }
   }
}

