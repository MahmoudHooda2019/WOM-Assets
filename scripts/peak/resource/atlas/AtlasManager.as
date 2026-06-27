package peak.resource.atlas
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import peak.cuckoo.core.Behavior;
   
   public class AtlasManager extends Behavior
   {
      
      public static const TYPE_ID:String = "AtlasManager";
      
      public static var INSTANCE:AtlasManager;
      
      public var maxTextureCount:int = 4;
      
      public var maxTextureSize:int;
      
      public var references:Dictionary;
      
      public function AtlasManager(param1:int, param2:int)
      {
         super();
         this.maxTextureCount = param2;
         this.maxTextureSize = param1;
         references = new Dictionary();
         INSTANCE = this;
      }
      
      override public function get typeId() : String
      {
         return "AtlasManager";
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      public function onContextComplete() : void
      {
      }
      
      public function onContextLoss() : void
      {
      }
      
      public function placeNewAsset(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : BlockReference
      {
         return new BlockReference(param1,0,0,1,1);
      }
   }
}

