package wom.model.component.behavior.mouse.follow
{
   import flash.utils.Dictionary;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.component.attribute.grid.PlannerGrid;
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   
   public class PlannerMouseFollower extends BaseMouseFollow
   {
      
      private var followers:Dictionary;
      
      private var followersBuildingCount:int = 0;
      
      private var plannerGrid:PlannerGrid;
      
      private var plannerRoot:WomPlannerRootV2;
      
      public function PlannerMouseFollower()
      {
         super();
         target = new Point3();
      }
      
      override public function init() : void
      {
         plannerRoot = owner.root as WomPlannerRootV2;
         userInteract = owner.root.userInteract;
         followers = new Dictionary();
         followersBuildingCount = 0;
         plannerGrid = plannerRoot.plannerGrid;
         startEnabled = false;
      }
      
      override public function onSignal0() : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Boolean = false;
         target.x = userInteract.projectedPosition.x / 3 >> 0;
         target.y = userInteract.projectedPosition.y / 3 >> 0;
         var _loc1_:Boolean = false;
         for each(var _loc2_ in followers)
         {
            if(_loc2_.building.position == null)
            {
               delete followers[_loc2_.building];
               _loc1_ = true;
               followersBuildingCount = followersBuildingCount - 1;
            }
            else
            {
               _loc5_ = target.x + _loc2_.offset.x;
               _loc4_ = target.y + _loc2_.offset.y;
               _loc2_.building.position.move(_loc5_,_loc4_,1000);
               _loc3_ = plannerGrid.checkCollision(_loc2_.building);
               if(_loc3_ != _loc2_.building.data.collide)
               {
                  _loc2_.building.data.collide = _loc3_;
                  _loc2_.building.viewManager.setCollision(_loc3_);
               }
            }
         }
         if(_loc1_)
         {
            disable();
         }
      }
      
      public function selectBuilding(param1:PlannerBuilding, param2:Boolean = false) : void
      {
         var _loc4_:PlannerBuilding = null;
         if(!followers[param1])
         {
            followers[param1] = new Follower(param1);
            param1.viewManager.setSelected(true);
            followersBuildingCount = followersBuildingCount + 1;
         }
         else if(param2)
         {
            delete followers[param1];
            param1.viewManager.setSelected(false);
            followersBuildingCount = followersBuildingCount - 1;
         }
         if(followersBuildingCount == 1)
         {
            for(var _loc3_ in followers)
            {
               _loc4_ = (followers[_loc3_] as Follower).building;
            }
            plannerRoot.inspectedBuilding = _loc4_;
         }
         else
         {
            plannerRoot.inspectedBuilding = null;
         }
      }
      
      public function isSelected(param1:PlannerBuilding) : Boolean
      {
         return param1 in followers;
      }
      
      public function deselectAll() : void
      {
         for each(var _loc1_ in followers)
         {
            _loc1_.building.viewManager.setSelected(false);
         }
         followers = new Dictionary();
         followersBuildingCount = 0;
      }
      
      public function startDrag() : void
      {
         target.x = userInteract.projectedPosition.x / 3 >> 0;
         target.y = userInteract.projectedPosition.y / 3 >> 0;
         for each(var _loc1_ in followers)
         {
            _loc1_.offset.x = _loc1_.building.position.point.x - target.x;
            _loc1_.offset.y = _loc1_.building.position.point.y - target.y;
            plannerGrid.unmarkArea(_loc1_.building);
         }
         enable();
      }
      
      public function stopDrag(param1:Boolean = true) : void
      {
         for each(var _loc2_ in followers)
         {
            if(param1)
            {
               _loc2_.building.viewManager.setSelected(false);
            }
            plannerGrid.markArea(_loc2_.building);
            _loc2_.building.position.move(_loc2_.building.position.point.x,_loc2_.building.position.point.y,0);
         }
         plannerRoot.checkCollision();
         if(param1)
         {
            followers = new Dictionary();
            followersBuildingCount = 0;
         }
         disable();
      }
   }
}

import flash.geom.Point;
import wom.model.component.entity.gamesprite.PlannerBuilding;

class Follower
{
   
   public var building:PlannerBuilding;
   
   public var offset:Point = new Point();
   
   public function Follower(param1:PlannerBuilding)
   {
      super();
      this.building = param1;
   }
}
