package peak.resource.atlas.starling
{
   import flash.display3D.textures.TextureBase;
   
   public class StarlingAtlasReference
   {
      
      public var name:String;
      
      public var uMin:Number;
      
      public var uMax:Number;
      
      public var vMin:Number;
      
      public var vMax:Number;
      
      public var x:int;
      
      public var y:int;
      
      public var atlasWidth:int;
      
      public var atlasHeight:int;
      
      public var frameX:Number = 0;
      
      public var frameY:Number = 0;
      
      public var frameXR:Number = 0;
      
      public var frameYR:Number = 0;
      
      public var width:Number;
      
      public var height:Number;
      
      public var starlingAtlas:StarlingAtlas;
      
      public var texture:TextureBase;
      
      public function StarlingAtlasReference()
      {
         super();
      }
   }
}

