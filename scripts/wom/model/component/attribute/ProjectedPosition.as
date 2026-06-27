package wom.model.component.attribute
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.dto.Point3;
   
   public class ProjectedPosition extends Position
   {
      
      public static const TYPE_ID:String = "Position";
      
      public function ProjectedPosition()
      {
         super(new Point3());
         this.projected = new Point3();
      }
      
      override public function get typeId() : String
      {
         return "Position";
      }
      
      override public function init() : void
      {
         ownerGS = owner as GameSprite;
         var _loc1_:GameSprite = ownerGS;
         _loc1_.validator.add(_loc1_);
         undefined;
      }
      
      override public function refreshPosition() : void
      {
         var _loc1_:GameSprite = ownerGS;
         _loc1_.validator.add(_loc1_);
         undefined;
      }
   }
}

