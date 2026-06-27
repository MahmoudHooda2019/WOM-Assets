package wom.model.component.attribute.projection
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.viewManager.UnitViewManager;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class IsoUnitProjection extends IsoProjection
   {
      
      public var shadow:GameSprite;
      
      protected var shadowOffset:Number;
      
      private var viewManager:UnitViewManager;
      
      public function IsoUnitProjection(param1:Point3)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.viewManager = (owner as Unit).viewManager;
         this.shadow = viewManager.shadow;
         if(shadow)
         {
            this.shadowOffset = -(owner as Unit).viewManager.shadow.position.point.y;
         }
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = (param1.x - param1.y) * pitchX / 2;
         param2.y = (param1.x + param1.y) * pitchY / 2;
         param2.z = param2.y + param2.x / 100000 + owner.id / 100000000;
         param2.x -= sortPoint.x;
         param2.y -= sortPoint.y;
         param2.y -= param1.z * 10;
         if(shadow)
         {
            shadow.position.projected.y = param1.z * 10 + shadowOffset;
            shadow.bounds.update();
         }
         if(viewManager.healthProgressBar)
         {
            viewManager.healthProgressBar.bounds.update();
         }
      }
   }
}

