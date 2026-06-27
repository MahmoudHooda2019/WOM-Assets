package peak.resource.atlas.native
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import peak.resource.atlas.*;
   import wom.Environment;
   
   public class NativeAtlasManager extends AtlasManager
   {
      
      public var atlasArchive:Vector.<NativeAtlas>;
      
      protected var uploadList:Vector.<Atlas>;
      
      protected var wait:Number;
      
      public function NativeAtlasManager(param1:int, param2:int)
      {
         var _loc3_:int = 0;
         super(param1,param2);
         uploadList = new Vector.<Atlas>();
         atlasArchive = new Vector.<NativeAtlas>(param2);
         _loc3_ = 0;
         while(_loc3_ < atlasArchive.length)
         {
            atlasArchive[_loc3_] = new NativeAtlas(this,param1,_loc3_);
            _loc3_++;
         }
      }
      
      override public function update() : void
      {
         wait -= owner.root.sync.precise;
         if(wait >= 0)
         {
            return;
         }
         wait = 60;
         var _loc1_:Atlas = uploadList.shift();
         if(_loc1_)
         {
            _loc1_.uploadTexture();
         }
         uploadList.length == 0 && disable();
      }
      
      public function addTextureToUploadList(param1:Atlas) : void
      {
         if(uploadList.indexOf(param1) == -1)
         {
            uploadList.push(param1);
         }
         enable();
      }
      
      override public function onContextComplete() : void
      {
         for each(var _loc1_ in atlasArchive)
         {
            if(_loc1_)
            {
               if(!_loc1_.texture)
               {
                  _loc1_.texture = Environment.gpu.context3D.createTexture(_loc1_.textureSize,_loc1_.textureSize,"bgra",false);
               }
               _loc1_.uploadTexture();
            }
         }
      }
      
      override public function onContextLoss() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Atlas = null;
         _loc2_ = 0;
         while(_loc2_ < atlasArchive.length)
         {
            _loc1_ = atlasArchive[_loc2_];
            if(_loc1_)
            {
               _loc1_.onContextLoss();
            }
            _loc2_++;
         }
      }
      
      private function place(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : BlockReference
      {
         var _loc7_:int = 0;
         var _loc6_:BlockReference = new BlockReference(param1,param2,param3,param4,param5);
         _loc7_ = 0;
         while(_loc7_ <= maxTextureCount)
         {
            if((atlasArchive[_loc7_] as NativeAtlas).place(_loc6_))
            {
               break;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      override public function placeNewAsset(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : BlockReference
      {
         var _loc6_:BlockReference = null;
         var _loc7_:Dictionary = null;
         var _loc8_:String = param2 + "" + param3 + "" + param4 + "" + param5;
         _loc6_ = checkIfAlreadyPlaced(param1,_loc8_);
         if(_loc6_ == null)
         {
            _loc6_ = place(param1,param2,param3,param4,param5);
            if(param1 in references)
            {
               references[param1][_loc8_] = _loc6_;
            }
            else
            {
               _loc7_ = new Dictionary();
               _loc7_[_loc8_] = _loc6_;
               references[param1] = _loc7_;
            }
         }
         return _loc6_;
      }
      
      private function checkIfAlreadyPlaced(param1:BitmapData, param2:String) : BlockReference
      {
         var _loc3_:Dictionary = null;
         if(param1 in references)
         {
            _loc3_ = references[param1];
            if(param2 in _loc3_)
            {
               return _loc3_[param2];
            }
         }
         return null;
      }
   }
}

