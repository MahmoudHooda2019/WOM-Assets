package wom.model.component.behavior.movement
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.Particle3DAnimationManager;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.game.unit.UnitInfo;
   
   public class MovementUnderGround extends MovementWalk
   {
      
      private var layer:Layer;
      
      private var _particle3DAnimationManager:Particle3DAnimationManager;
      
      private var _unitInfo:UnitInfo;
      
      private var frameNum:int;
      
      private var tempPoint:Point3;
      
      private var ownerSprite:GameSprite;
      
      public function MovementUnderGround()
      {
         super();
         tempPoint = new Point3();
      }
      
      override public function init() : void
      {
         super.init();
         ownerSprite = owner as GameSprite;
         frameNum = 0;
         layer = owner.root.layers[3];
         _particle3DAnimationManager = (owner.root as WomGameRoot).particle3DAnimationManager;
         _unitInfo = (owner as Unit).data.info;
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         super.update();
         frameNum = frameNum + 1;
         if(frameNum % 5 == 0)
         {
            tempPoint.x = ownerPosition.projected.x;
            tempPoint.y = ownerPosition.projected.y;
            _particle3DAnimationManager.groundSwell(tempPoint);
            _loc1_ = Math.random();
            if(_loc1_ < 0.3)
            {
               _particle3DAnimationManager.spillSoilFromUnderground(tempPoint);
            }
            else if(_loc1_ < 0.5)
            {
               _particle3DAnimationManager.spillStoneFromUnderground(tempPoint);
            }
         }
      }
      
      override protected function start() : void
      {
         super.start();
         layer.remove(ownerSprite);
      }
      
      override protected function stop() : void
      {
         if(_unitInfo.healthPoints > 0)
         {
            layer.add(ownerSprite);
         }
         super.stop();
      }
   }
}

