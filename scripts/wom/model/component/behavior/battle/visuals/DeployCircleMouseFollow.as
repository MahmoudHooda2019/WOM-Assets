package wom.model.component.behavior.battle.visuals
{
   import flash.geom.Point;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.grid.CityGrid;
   import wom.model.component.behavior.battle.*;
   import wom.model.component.behavior.catapult.BaseCatapult;
   import wom.model.component.behavior.mouse.follow.BaseMouseFollow;
   
   public class DeployCircleMouseFollow extends BaseMouseFollow
   {
      
      private var cityGrid:CityGrid;
      
      public var collide:Boolean;
      
      public var deploymentMode:int;
      
      private var battleManager:BattleManager;
      
      public var moved:Boolean;
      
      public var catapultObject:Entity;
      
      private var catapultBehavior:BaseCatapult;
      
      private var view:CompositeView;
      
      private var radius:int;
      
      private var womRoot:WomGameRoot;
      
      private var bounds:RenderBounds;
      
      private var offset:Point;
      
      public function DeployCircleMouseFollow(param1:int, param2:Entity = null)
      {
         this.deploymentMode = param1;
         this.catapultObject = param2;
         super();
      }
      
      override public function init() : void
      {
         super.init();
         offset = new Point();
         cityGrid = owner.root.componentManager["CityGrid"] as CityGrid;
         womRoot = owner.root as WomGameRoot;
         battleManager = womRoot.battleManager;
         moved = false;
         bounds = (owner as GameSprite).bounds;
         view = (owner as GameSprite).view as CompositeView;
         radius = 10;
         if(deploymentMode == 2)
         {
            catapultBehavior = catapultObject.componentManager["BaseCatapult"] as BaseCatapult;
         }
         onSignal0();
      }
      
      override public function onSignal0() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         projection.reverse(userInteract.projectedPosition,target);
         target.x -= offset.x;
         target.y -= offset.y;
         target.x >>= 0;
         target.y >>= 0;
         position.move(target.x,target.y,0);
         moved = true;
         var _loc1_:int = target.x + radius;
         var _loc2_:int = target.y + radius;
         if(deploymentMode == 1)
         {
            collide = false;
            _loc4_ = target.x - radius;
            while(_loc4_ < _loc1_)
            {
               _loc3_ = target.y - radius;
               while(_loc3_ < _loc2_)
               {
                  if((_loc4_ - target.x) * (_loc4_ - target.x) + (_loc3_ - target.y) * (_loc3_ - target.y) <= radius * radius && cityGrid.grid[(_loc4_ << 10) + _loc3_])
                  {
                     collide = true;
                  }
                  _loc3_++;
               }
               _loc4_++;
            }
            view.colorFilter(collide ? 16711680 : 16777215);
         }
         else if(deploymentMode == 2)
         {
            catapultBehavior.collideDeployCircle(target);
            if(womRoot.mobileOptionsPanel)
            {
               womRoot.mobileOptionsPanel.x = position.projected.x - (womRoot.mobileOptionsPanel.width >> 1);
               womRoot.mobileOptionsPanel.y = position.projected.y - 100;
            }
         }
      }
      
      override public function enable() : void
      {
         super.enable();
         owner.root.projection.reverse(owner.root.userInteract.projectedPosition,target);
         offset = new Point(target.x - (owner as GameSprite).position.point.x,target.y - (owner as GameSprite).position.point.y);
      }
      
      override public function destroy() : void
      {
         if(catapultBehavior)
         {
            catapultBehavior.resetCollusionFilters();
         }
         super.destroy();
      }
   }
}

