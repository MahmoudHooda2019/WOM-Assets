package wom.model.domain.domaininfoobject
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import wom.model.game.building.BuildMenuCategory;
   
   public class ConstructableTypeDIO
   {
      
      public var id:int;
      
      public var kind:ConstructableKindTypeDIO;
      
      public var baseSize:int;
      
      public var buildMenuCategory:BuildMenuCategory;
      
      public var plannerIcon:String;
      
      public var buildingSpecificInfo:Dictionary;
      
      public var mobileUIOffset:Point;
      
      public function ConstructableTypeDIO(param1:int, param2:ConstructableKindTypeDIO, param3:int, param4:BuildMenuCategory, param5:String, param6:Dictionary, param7:Point)
      {
         super();
         this.id = param1;
         this.kind = param2;
         this.baseSize = param3;
         this.buildMenuCategory = param4;
         this.plannerIcon = param5;
         this.buildingSpecificInfo = param6;
         this.mobileUIOffset = param7;
      }
   }
}

