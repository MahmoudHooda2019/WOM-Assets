package wom.model.component.attribute.projection
{
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   
   public class UnitOffsetProjection extends IsoUnitProjection
   {
      
      private var xDif:Number;
      
      private var yDif:Number;
      
      private var ownerUnit:Unit;
      
      private var compositeView:CompositeView;
      
      private var animationSortPoint:Point;
      
      public var healthProgressBar:GameSprite;
      
      private var layers:Array;
      
      public function UnitOffsetProjection(param1:Point3, param2:int, param3:CompositeView)
      {
         super(param1);
         xDif = param2 * pitchX / 2;
         yDif = param2 * pitchY;
         this.compositeView = param3;
      }
      
      override public function init() : void
      {
         ownerUnit = owner as Unit;
         animationSortPoint = ownerUnit.isBeast ? (ownerUnit.data.typeDIO as BeastTypeDIO).animationSortPointsPerStage[ownerUnit.data.levelIndex] : ownerUnit.data.typeDIO.animationSortPoint;
         layers = owner.root.layers;
         addShadowInCBCM();
         addHealthBarInCBCM();
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = (param1.x - param1.y) * pitchX / 2;
         param2.y = (param1.x + param1.y) * pitchY / 2;
         param2.x -= sortPoint.x - xDif;
         param2.y -= sortPoint.y + yDif;
         param2.z = param2.y / 10 + param2.x / -1000000 + owner.id / 1000000000 + 25;
         if(shadow)
         {
            shadow.position.projected.x = param2.x + animationSortPoint.x - shadowOffset;
            shadow.position.projected.y = param2.y + animationSortPoint.y;
            shadow.position.projected.z = param2.z;
            shadow.bounds.update();
         }
         if(healthProgressBar)
         {
            healthProgressBar.position.projected.x = param2.x + animationSortPoint.x - 14;
            healthProgressBar.position.projected.y = param2.y;
            healthProgressBar.bounds.update();
         }
      }
      
      public function addShadowInCBCM() : void
      {
         if(!shadow)
         {
            if(ownerUnit.viewManager.shadow)
            {
               this.shadow = ownerUnit.viewManager.shadow;
               if(shadow.parent && shadow.parent == ownerUnit)
               {
                  (owner.root.layers[2] as Layer).remove(shadow);
                  shadow.parent.removeChild(shadow);
               }
               this.shadowOffset = ownerUnit.viewManager.shadowOffset;
               compositeView.addChild(shadow);
               compositeView.owner.addChild(shadow);
               shadow.composite = compositeView.owner as GameSprite;
               shadow.componentManager.add(shadow.bounds = new CompositeChildRenderBounds());
               shadow.componentManager.add(new VoidProjection());
               shadow.init();
               transform(ownerUnit.position.point,ownerUnit.position.projected);
            }
         }
      }
      
      public function addHealthBarInCBCM() : void
      {
         if(!healthProgressBar)
         {
            if(ownerUnit.viewManager.healthProgressBar)
            {
               this.healthProgressBar = ownerUnit.viewManager.healthProgressBar;
               if(healthProgressBar.parent && healthProgressBar.parent == ownerUnit)
               {
                  healthProgressBar.parent.removeChild(healthProgressBar);
               }
               compositeView.owner.addChild(healthProgressBar);
               healthProgressBar.composite = compositeView.owner as GameSprite;
               healthProgressBar.componentManager.add(healthProgressBar.bounds = new CompositeChildRenderBounds());
               healthProgressBar.init();
               (layers[4] as Layer).add(healthProgressBar);
               transform(ownerUnit.position.point,ownerUnit.position.projected);
            }
         }
      }
      
      override public function disable() : void
      {
         clearShadow();
         clearHealthbar();
      }
      
      public function clearHealthbar() : void
      {
         if(healthProgressBar)
         {
            healthProgressBar.parent && healthProgressBar.parent.removeChild(ownerUnit.viewManager.shadow);
            (layers[4] as Layer).remove(healthProgressBar);
            ownerUnit.viewManager.healthProgressBar = null;
            healthProgressBar = null;
         }
      }
      
      public function clearShadow() : void
      {
         if(shadow)
         {
            shadow.parent && shadow.parent.removeChild(shadow);
            compositeView.clearChild(shadow);
            ownerUnit.viewManager.shadow = null;
            shadow = null;
         }
      }
   }
}

