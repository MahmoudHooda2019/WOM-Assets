package wom.model.component.behavior.mouse.follow
{
   import flash.geom.Rectangle;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.grid.CityGrid;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   
   public class ConstructableMouseFollow extends BaseMouseFollow
   {
      
      public static const DECORATION_BOUNDARY:int = 50;
      
      protected var offset:Point3;
      
      protected var baseSize:int;
      
      protected var build:Boolean;
      
      public var collide:Boolean = false;
      
      protected var lastCollideState:Boolean = false;
      
      protected var cityGrid:CityGrid;
      
      protected var isDecoration:Boolean = false;
      
      protected var womGameRoot:WomGameRoot;
      
      private var ownerSprite:GameSprite;
      
      private var compositeView:CompositeView;
      
      private var offsetX:int;
      
      private var offsetY:int;
      
      public function ConstructableMouseFollow(param1:Boolean = false)
      {
         super();
         target = new Point3();
         this.build = param1;
      }
      
      override public function init() : void
      {
         super.init();
         womGameRoot = owner.root as WomGameRoot;
         ownerSprite = owner as GameSprite;
         isDecoration = owner is Decoration;
         baseSize = owner is Building ? (owner as Building).data.buildingTypeDIO.baseSize : (owner is Decoration ? (owner as Decoration).data.dio.baseSize : 0);
         cityGrid = owner.root.componentManager["CityGrid"] as CityGrid;
         projection = owner.componentManager["BaseProjection"] as BaseProjection;
         compositeView = ownerSprite.view as CompositeView;
         var _loc1_:IsoProjection = womGameRoot.projection as IsoProjection;
         offsetX = _loc1_.pitchX * baseSize;
         offsetY = _loc1_.pitchY * baseSize + 20;
      }
      
      override public function onSignal0() : void
      {
         projection.reverse(userInteract.projectedPosition,target);
         target.x -= offset.x;
         target.y -= offset.y;
         target.x >>= 0;
         target.y >>= 0;
         updateState(target);
      }
      
      public function updateState(param1:Point3) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         position.move(param1.x,param1.y,0);
         position.projected.z += 10000;
         collide = cityGrid.checkCollision(new Rectangle(param1.x,param1.y,baseSize,baseSize),isDecoration ? 50 : 0);
         if(collide != lastCollideState)
         {
            if(collide)
            {
               compositeView.colorFilterMain(11141120);
            }
            else
            {
               compositeView.colorFilterMain();
            }
            lastCollideState = collide;
            if(womGameRoot.mobileOptionsPanel)
            {
               womGameRoot.mobileOptionsPanel.okButton.isEnabled = !collide;
            }
         }
         if(womGameRoot.mobileOptionsPanel)
         {
            _loc3_ = womGameRoot.movingConstructable.position.projected.x;
            _loc2_ = womGameRoot.movingConstructable.position.projected.y;
            womGameRoot.mobileOptionsPanel.x = _loc3_ + (offsetX - womGameRoot.mobileOptionsPanel.width >> 1);
            womGameRoot.mobileOptionsPanel.y = _loc2_ - (offsetY + womGameRoot.mobileOptionsPanel.height);
         }
      }
      
      public function warnNewDeploy(param1:Point3) : void
      {
      }
      
      override public function disable() : void
      {
         super.disable();
      }
      
      override public function enable() : void
      {
         super.enable();
         compositeView.alphaFilterMain(0.7);
         if(build)
         {
            offset = new Point3(baseSize >> 1,baseSize >> 1);
         }
         else
         {
            owner.root.projection.reverse(owner.root.userInteract.projectedPosition,target);
            offset = new Point3(target.x - (owner as GameSprite).position.point.x,target.y - (owner as GameSprite).position.point.y);
         }
      }
   }
}

