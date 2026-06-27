package peak.cuckoo.game.attribute
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.dto.Point3;
   
   public class Position extends Attribute
   {
      
      public static const TYPE_ID:String = "Position";
      
      public var point:Point3;
      
      public var projected:Point3;
      
      protected var projection:BaseProjection;
      
      protected var ownerGS:GameSprite;
      
      public function Position(param1:Point3)
      {
         super();
         this.point = param1;
         this.projected = new Point3();
      }
      
      override public function get typeId() : String
      {
         return "Position";
      }
      
      override public function init() : void
      {
         super.init();
         projection = owner.componentManager["BaseProjection"];
         if(projection == null)
         {
            projection = owner.parent.componentManager["BaseProjection"];
         }
         projection.init();
         projection.transform(point,projected);
         ownerGS = owner as GameSprite;
         var _loc1_:GameSprite = ownerGS;
         _loc1_.validator.add(_loc1_);
         undefined;
      }
      
      public function move(param1:Number, param2:Number, param3:Number) : void
      {
         point.x = param1;
         point.y = param2;
         point.z = param3;
         projection.transform(point,projected);
         var _loc4_:GameSprite = ownerGS;
         _loc4_.validator.add(_loc4_);
         undefined;
      }
      
      public function movePoint(param1:Point3) : void
      {
         point.x = param1.x;
         point.y = param1.y;
         projection.transform(point,projected);
         var _loc2_:GameSprite = ownerGS;
         _loc2_.validator.add(_loc2_);
         undefined;
      }
      
      public function refreshPosition() : void
      {
         projection.transform(point,projected);
         var _loc1_:GameSprite = ownerGS;
         _loc1_.validator.add(_loc1_);
         undefined;
      }
   }
}

