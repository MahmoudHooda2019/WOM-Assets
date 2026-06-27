package wom.model.game.building
{
   import flash.geom.Point;
   
   public class BuildingTypeVisual
   {
      
      public var id:String;
      
      public var offset:Point;
      
      public var layer:int;
      
      public var fpsChangeRate:int;
      
      public var mainVisual:Boolean;
      
      public var mainVisualFront:Boolean;
      
      public var sortPoint:Point;
      
      public var visualType:String;
      
      public var frameWidth:int;
      
      public function BuildingTypeVisual(param1:String, param2:Point, param3:int, param4:Boolean, param5:Boolean, param6:Point, param7:String, param8:int = 0, param9:int = 0)
      {
         super();
         this.id = param1;
         this.offset = param2;
         this.layer = param3;
         this.fpsChangeRate = param9;
         this.mainVisual = param4;
         this.sortPoint = param6;
         this.visualType = param7;
         this.frameWidth = param8;
         this.mainVisualFront = param5;
      }
   }
}

