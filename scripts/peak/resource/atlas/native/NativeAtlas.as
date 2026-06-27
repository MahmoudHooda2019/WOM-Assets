package peak.resource.atlas.native
{
   import flash.display.BitmapData;
   import flash.display3D.textures.Texture;
   import peak.cuckoo.game.behavior.render.gpu.GpuImage;
   import peak.resource.atlas.*;
   import wom.Environment;
   
   public class NativeAtlas extends Atlas
   {
      
      public var bitmapData:BitmapData;
      
      public var shelves:Vector.<Shelf>;
      
      public var blocks:Vector.<BlockReference>;
      
      public var tidy:Boolean;
      
      private var availableY:int;
      
      private var posY:int;
      
      public function NativeAtlas(param1:AtlasManager, param2:int, param3:uint)
      {
         super(param1,param2,param3);
         availableY = param2;
         posY = 0;
         blocks = new Vector.<BlockReference>();
         shelves = new Vector.<Shelf>();
      }
      
      protected function init() : void
      {
         bitmapData = new BitmapData(textureSize,textureSize,true,0);
         if(Environment.gpu.context3D)
         {
            texture = Environment.gpu.context3D.createTexture(textureSize,textureSize,"bgra",false);
         }
      }
      
      override public function onContextLoss() : void
      {
         var _loc4_:int = 0;
         var _loc1_:BlockReference = null;
         var _loc3_:int = 0;
         var _loc2_:GpuImage = null;
         _loc4_ = 0;
         while(_loc4_ < blocks.length)
         {
            _loc1_ = blocks[_loc4_];
            _loc3_ = 0;
            while(_loc3_ < _loc1_.gpuImages.length)
            {
               _loc2_ = _loc1_.gpuImages[_loc3_];
               _loc2_.onContextLoss();
               _loc3_++;
            }
            _loc4_++;
         }
         texture = Environment.gpu.context3D.createTexture(textureSize,textureSize,"bgra",false);
         uploadTexture();
      }
      
      public function addUploadList() : void
      {
         (atlasManager as NativeAtlasManager).addTextureToUploadList(this);
      }
      
      override public function uploadTexture() : void
      {
         if(!bitmapData)
         {
            init();
         }
         if(texture)
         {
            (texture as Texture).uploadFromBitmapData(bitmapData);
         }
      }
      
      public function place(param1:BlockReference) : Boolean
      {
         tryToPlace(param1);
         if(!param1.placed && !tidy)
         {
         }
         addUploadList();
         return param1.placed;
      }
      
      private function tryToPlace(param1:BlockReference) : void
      {
         var _loc3_:Shelf = null;
         for each(var _loc2_ in shelves)
         {
            if(_loc2_.height >= param1.h && _loc2_.availableX >= param1.w && (!_loc3_ || _loc3_ && _loc3_.height > _loc2_.height))
            {
               _loc3_ = _loc2_;
            }
         }
         if(!_loc3_)
         {
            if(param1.h > availableY)
            {
               return;
            }
            shelves.push(_loc3_ = new Shelf(this,posY,param1.h,textureSize));
            posY += param1.h;
            availableY -= param1.h;
         }
         _loc3_.place(param1);
      }
      
      private function shuffle() : void
      {
         var blockReference:BlockReference;
         var blocksToOrganize:Vector.<BlockReference> = blocks;
         bitmapData.fillRect(bitmapData.rect,0);
         availableY = textureSize;
         posY = 0;
         blocks = new Vector.<BlockReference>();
         shelves.length = 0;
         blocksToOrganize.sort(function(param1:BlockReference, param2:BlockReference):int
         {
            return param1.bitmapData.height < param2.bitmapData.height ? 1 : -1;
         });
         for each(blockReference in blocksToOrganize)
         {
            blockReference.placed = false;
            tryToPlace(blockReference);
            if(!blockReference.placed)
            {
               trace("GPU TEXTURE OVER FLOW !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ");
            }
         }
         tidy = true;
      }
   }
}

