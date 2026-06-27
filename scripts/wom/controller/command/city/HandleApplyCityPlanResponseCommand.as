package wom.controller.command.city
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.dto.PlannerBuildingDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.message.response.ApplyCityPlanResponse;
   
   public class HandleApplyCityPlanResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleApplyCityPlanResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ApplyCityPlanResponse = messageReceivedEvent.message as ApplyCityPlanResponse;
         if(_loc1_.resultCode == 0)
         {
            applyCityPlan(_loc1_.plan);
         }
      }
      
      public function applyCityPlan(param1:Dictionary) : void
      {
         var _loc4_:PlannerBuildingDTO = null;
         var _loc5_:Point = null;
         if(param1)
         {
            for each(var _loc2_ in city.buildings)
            {
               _loc4_ = param1[_loc2_.instanceId];
               if(_loc4_)
               {
                  _loc5_ = new Point(_loc4_.position.point.x,_loc4_.position.point.y);
                  _loc2_.position.x = _loc5_.x;
                  _loc2_.position.y = _loc5_.y;
                  coreManager.moveBuildingByPlanner(_loc4_.instanceId,_loc5_);
               }
            }
            for each(var _loc3_ in city.decorations)
            {
               _loc4_ = param1[_loc3_.instanceId];
               if(_loc4_)
               {
                  _loc5_ = new Point(_loc4_.position.point.x,_loc4_.position.point.y);
                  _loc3_.position.x = _loc5_.x;
                  _loc3_.position.y = _loc5_.y;
                  coreManager.moveDecorationByPlanner(_loc4_.instanceId,_loc5_);
               }
            }
         }
      }
   }
}

