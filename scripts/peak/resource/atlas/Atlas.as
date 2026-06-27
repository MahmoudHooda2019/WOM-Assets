package peak.resource.atlas
{
   import flash.display3D.textures.TextureBase;
   
   public class Atlas
   {
      
      public static const PADDING:int = 1;
      
      public var textureSize:int;
      
      public var atlasManager:AtlasManager;
      
      public var texture:TextureBase;
      
      public var premultipliedAlpha:Boolean;
      
      public var compressed:Boolean;
      
      public var index:uint;
      
      public function Atlas(param1:AtlasManager, param2:int, param3:uint)
      {
         super();
         this.atlasManager = param1;
         this.textureSize = param2;
         this.index = param3;
         init();
      }
      
      private function init() : void
      {
      }
      
      public function uploadTexture() : void
      {
      }
      
      public function onContextLoss() : void
      {
      }
   }
}

